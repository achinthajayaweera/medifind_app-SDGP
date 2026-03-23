"""
pharmacy_search.py — The complete pharmacy search algorithm.

This is the ONLY file that contains the search logic.
It calls one Supabase RPC function and processes the result.

Deploy on Railway with your existing Python backend.
"""

import os
import httpx
from dataclasses import dataclass

# ── Supabase config (set these as Railway environment variables) ──
SUPABASE_URL = os.environ["SUPABASE_URL"]       # https://xxxxx.supabase.co
SUPABASE_KEY = os.environ["SUPABASE_ANON_KEY"]  # your anon/service key
