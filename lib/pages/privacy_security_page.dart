import 'package:flutter/material.dart';

class PrivacySecurityPage extends StatefulWidget {
  const PrivacySecurityPage({super.key});
  @override
  State<PrivacySecurityPage> createState() => _PrivacySecurityPageState();
}

class _PrivacySecurityPageState extends State<PrivacySecurityPage> {
  bool _twoFactor = false;
  bool _dataSharing = false;
  bool _locationAccess = true;
  bool _biometric = false;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: const Color(0xFF0796DE),
      body: Column(children: [
        ClipRect(
            child: Container(
          color: const Color(0xFF0796DE),
          child: Stack(clipBehavior: Clip.hardEdge, children: [
            Positioned(
                right: -30,
                top: -40,
                child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 25,
                            color: Colors.white.withOpacity(0.12))))),
            Padding(
              padding: EdgeInsets.fromLTRB(8, topPadding + 8, 16, 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back,
                              color: Colors.white, size: 24)),
                      const SizedBox(width: 8),
                    ]),
                    const SizedBox(height: 4),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Privacy & Security',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700)),
                            Text('Manage your data and security',
                                style: TextStyle(
                                    color: Color(0xFFD0EEFF),
                                    fontSize: 13,
                                    fontFamily: 'Poppins')),
                          ]),
                    ),
                  ]),
            ),
          ]),
        )),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: Color(0xFFF5F7FF),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28))),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _section('Security', [
                      _toggleRow(
                          'Two-Factor Authentication',
                          'Extra layer of account security',
                          Icons.verified_user_rounded,
                          _twoFactor,
                          (v) => setState(() => _twoFactor = v)),
                      _toggleRow(
                          'Biometric Login',
                          'Use Face ID or fingerprint',
                          Icons.fingerprint_rounded,
                          _biometric,
                          (v) => setState(() => _biometric = v)),
                      _actionRow(
                          'Change Password',
                          'Update your account password',
                          Icons.lock_rounded,
                          () => _showSnack('Change password coming soon')),
                    ]),
                    const SizedBox(height: 20),
                    _section('Data & Privacy', [
                      _toggleRow(
                          'Data Sharing',
                          'Share anonymised data to improve services',
                          Icons.share_rounded,
                          _dataSharing,
                          (v) => setState(() => _dataSharing = v)),
                      _toggleRow(
                          'Location Access',
                          'Allow location for nearby pharmacies',
                          Icons.location_on_rounded,
                          _locationAccess,
                          (v) => setState(() => _locationAccess = v)),
                      _actionRow(
                          'Download My Data',
                          'Get a copy of your personal data',
                          Icons.download_rounded,
                          () => _showSnack('Data export coming soon')),
                      _actionRow(
                          'Delete Account',
                          'Permanently remove your account',
                          Icons.delete_forever_rounded,
                          () => _confirmDelete(),
                          isDestructive: true),
                    ]),
                    const SizedBox(height: 20),
                    _section('Legal', [
                      _actionRow(
                          'Privacy Policy',
                          'Read our privacy policy',
                          Icons.privacy_tip_rounded,
                          () => _showSnack('Opening privacy policy...')),
                      _actionRow(
                          'Terms of Service',
                          'View terms and conditions',
                          Icons.description_rounded,
                          () => _showSnack('Opening terms...')),
                    ]),
                  ]),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title,
          style: const TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700)),
      const SizedBox(height: 10),
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xFF0796DE).withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 3))
            ]),
        child: Column(
            children: List.generate(
                children.length,
                (i) => Column(children: [
                      children[i],
                      if (i < children.length - 1)
                        const Divider(
                            height: 1,
                            indent: 16,
                            endIndent: 16,
                            color: Color(0xFFF1F5F9)),
                    ]))),
      ),
    ]);
  }

  Widget _toggleRow(String title, String sub, IconData icon, bool val,
      ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(children: [
        Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
                color: const Color(0xFF0796DE).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: const Color(0xFF0796DE), size: 20)),
        const SizedBox(width: 12),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600)),
          Text(sub,
              style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 11,
                  fontFamily: 'Poppins')),
        ])),
        Switch(
            value: val,
            onChanged: onChanged,
            activeColor: const Color(0xFF0796DE)),
      ]),
    );
  }

  Widget _actionRow(String title, String sub, IconData icon, VoidCallback onTap,
      {bool isDestructive = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(children: [
          Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                  color: isDestructive
                      ? const Color(0xFFEF5350).withOpacity(0.1)
                      : const Color(0xFF0796DE).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(icon,
                  color: isDestructive
                      ? const Color(0xFFEF5350)
                      : const Color(0xFF0796DE),
                  size: 20)),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: TextStyle(
                        color: isDestructive
                            ? const Color(0xFFEF5350)
                            : const Color(0xFF0F172A),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600)),
                Text(sub,
                    style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 11,
                        fontFamily: 'Poppins')),
              ])),
          Icon(Icons.chevron_right_rounded,
              color: isDestructive
                  ? const Color(0xFFEF5350)
                  : const Color(0xFF94A3B8)),
        ]),
      ),
    );
  }

  void _showSnack(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(msg, style: const TextStyle(fontFamily: 'Poppins')),
          backgroundColor: const Color(0xFF0796DE),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16)));

  void _confirmDelete() => showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: const Text('Delete Account',
                style: TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
            content: const Text(
                'This will permanently delete your account and all data. This cannot be undone.',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 13)),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel',
                      style: TextStyle(fontFamily: 'Poppins'))),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Delete',
                      style: TextStyle(
                          color: Color(0xFFEF5350), fontFamily: 'Poppins'))),
            ],
          ));
}
