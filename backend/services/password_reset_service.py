import os
import smtplib
from email.message import EmailMessage
from typing import Optional

from supabase import Client, create_client


def _env(name: str, default: str = "") -> str:
    return os.environ.get(name, default).strip()


class PasswordResetService:
    def __init__(self) -> None:
        url = _env("SUPABASE_URL")
        key = _env("SUPABASE_SERVICE_ROLE_KEY")
        if not url or not key:
            raise RuntimeError(
                "SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY must be configured."
            )
        self.supabase: Client = create_client(url, key)
        self.otp_expiry_minutes = int(_env("OTP_EXPIRY_MINUTES", "10"))  # Email text hint.
        self.password_reset_dev_mode = (
            _env("PASSWORD_RESET_DEV_MODE", "false").lower() == "true"
        )

    def _resolve_email(self, identifier: str) -> Optional[str]:
        clean = identifier.strip().lower()
        if not clean:
            return None
        if "@" in clean:
            return clean

        try:
            row = (
                self.supabase.table("user_credentials")
                .select("email")
                .eq("username", clean)
                .limit(1)
                .execute()
            )
            if row.data:
                return (row.data[0].get("email") or "").strip().lower() or None
        except Exception:
            pass

        try:
            row = (
                self.supabase.table("user_logins")
                .select("email")
                .eq("username", clean)
                .limit(1)
                .execute()
            )
            if row.data:
                return (row.data[0].get("email") or "").strip().lower() or None
        except Exception:
            pass

        try:
            rpc = self.supabase.rpc(
                "get_email_by_username", {"input_username": clean}
            ).execute()
            if rpc.data:
                return str(rpc.data).strip().lower()
        except Exception:
            pass

        return None

    def _send_otp_email(self, email: str, otp: str) -> None:
        host = _env("SMTP_HOST")
        port = int(_env("SMTP_PORT", "587"))
        user = _env("SMTP_USER")
        password = _env("SMTP_PASSWORD")
        from_header = _env("SMTP_FROM", user)
        use_ssl = _env("SMTP_USE_SSL", "false").lower() == "true"

        if not host or not user or not password:
            raise RuntimeError("SMTP settings are incomplete.")

        msg = EmailMessage()
        msg["Subject"] = "MediFind Password Reset OTP"
        msg["From"] = from_header
        msg["To"] = email
        msg.set_content(
            f"Your MediFind OTP is {otp}. It expires in {self.otp_expiry_minutes} minutes."
        )

        if use_ssl:
            with smtplib.SMTP_SSL(host, port) as smtp:
                smtp.login(user, password)
                smtp.send_message(msg)
        else:
            with smtplib.SMTP(host, port) as smtp:
                smtp.starttls()
                smtp.login(user, password)
                smtp.send_message(msg)

    def request_password_reset_otp(self, identifier: str) -> dict:
        email = self._resolve_email(identifier)

        # Do not disclose account existence.
        if not email:
            return {"sent": True, "email": None}

        # Generates a recovery OTP via Supabase Auth without using signInWithOtp.
        recovery = self.supabase.auth.admin.generate_link(
            {"type": "recovery", "email": email}
        )
        otp = recovery.properties.email_otp
        try:
            self._send_otp_email(email, otp)
            return {"sent": True, "email": email, "delivery": "email"}
        except Exception:
            if self.password_reset_dev_mode:
                return {
                    "sent": True,
                    "email": email,
                    "delivery": "dev_mode",
                    "dev_otp": otp,
                }
            raise RuntimeError(
                "Unable to send OTP email. Please check SMTP configuration."
            )

    def verify_otp_and_reset_password(
        self, identifier: str, otp: str, new_password: str
    ) -> dict:
        if len(new_password) < 6:
            raise ValueError("Password must be at least 6 characters.")

        email = self._resolve_email(identifier)
        if not email:
            raise ValueError("Invalid OTP or account.")

        try:
            verification = self.supabase.auth.verify_otp(
                {"email": email, "token": otp.strip(), "type": "recovery"}
            )
        except Exception:
            raise ValueError("Invalid or expired OTP.")

        if not verification.session:
            raise ValueError("Invalid or expired OTP.")

        try:
            self.supabase.auth.set_session(
                verification.session.access_token,
                verification.session.refresh_token,
            )
            self.supabase.auth.update_user({"password": new_password})
            self.supabase.auth.sign_out()
        except Exception:
            raise RuntimeError("Password update failed after OTP verification.")

        return {"reset": True, "email": email}
