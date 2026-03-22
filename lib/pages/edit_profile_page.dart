import 'package:flutter/material.dart';
import 'user_store.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  late TextEditingController _nameCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _dobCtrl;
  late TextEditingController _addressCtrl;

  String _selectedEmoji = '';
  Color _selectedColor = const Color(0xFF0796DE);

  static const _palette = [
    Color(0xFF0796DE),
    Color(0xFF4CAF50),
    Color(0xFFFF9800),
    Color(0xFFE91E63),
    Color(0xFF9C27B0),
    Color(0xFF3F51B5),
    Color(0xFFF44336),
    Color(0xFF009688),
  ];

  static const _emojiOptions = [
    '😀',
    '😎',
    '🥳',
    '😍',
    '🤩',
    '😊',
    '🔥',
    '💪',
    '🌟',
    '🦁',
    '🐯',
    '🦊',
    '🐧',
    '🐬',
    '🦋',
    '🌈',
    '⚡',
    '🎯',
    '🏆',
    '💎',
  ];

  @override
  void initState() {
    super.initState();
    final s = UserStore.instance;
    _nameCtrl = TextEditingController(text: s.name == 'User' ? '' : s.name);
    _phoneCtrl = TextEditingController(text: s.phone);
    _dobCtrl = TextEditingController(text: s.dateOfBirth);
    _addressCtrl = TextEditingController(text: '');
    // emoji — ignore the default '👤' placeholder
    _selectedEmoji = (s.emoji == '👤') ? '' : s.emoji;
    _selectedColor = Color(s.avatarColorValue);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _dobCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      _snack('Name cannot be empty', error: true);
      return;
    }
    final s = UserStore.instance;
    s.name = name[0].toUpperCase() + name.substring(1);
    s.phone = _phoneCtrl.text.trim();
    s.dateOfBirth = _dobCtrl.text.trim();
    s.emoji = _selectedEmoji.isEmpty ? '👤' : _selectedEmoji;
    s.avatarColorValue = _selectedColor.value;
    _snack('Profile updated!', error: false);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) Navigator.pop(context, true);
    });
  }

  void _snack(String msg, {required bool error}) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg,
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 13)),
        backgroundColor:
            error ? const Color(0xFFEF5350) : const Color(0xFF4CAF50),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      ));

  void _showEmojiPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF001D70),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 48),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 18),
          const Text('Choose Avatar',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          Wrap(spacing: 12, runSpacing: 12, children: [
            // No emoji option
            GestureDetector(
              onTap: () {
                setState(() => _selectedEmoji = '');
                Navigator.pop(context);
              },
              child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _selectedEmoji.isEmpty
                          ? _selectedColor
                          : Colors.white.withOpacity(0.1),
                      border: Border.all(
                          color: _selectedEmoji.isEmpty
                              ? Colors.white
                              : Colors.white.withOpacity(0.2),
                          width: 2)),
                  child: Icon(Icons.person_rounded,
                      color: _selectedEmoji.isEmpty
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      size: 28)),
            ),
            ..._emojiOptions.map((e) => GestureDetector(
                  onTap: () {
                    setState(() => _selectedEmoji = e);
                    Navigator.pop(context);
                  },
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _selectedEmoji == e
                              ? Colors.white.withOpacity(0.2)
                              : Colors.white.withOpacity(0.07),
                          border: Border.all(
                              color: _selectedEmoji == e
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 2)),
                      child: Center(
                          child:
                              Text(e, style: const TextStyle(fontSize: 28)))),
                )),
          ]),
          const SizedBox(height: 8),
        ]),
      ),
    );
  }

  Future<void> _pickDate() async {
    final initial = _dobCtrl.text.isNotEmpty
        ? DateTime.tryParse(_dobCtrl.text) ?? DateTime(2000)
        : DateTime(2000);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (ctx, child) => Theme(
        data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF0796DE))),
        child: child!,
      ),
    );
    if (picked != null) {
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      setState(() => _dobCtrl.text =
          '${months[picked.month - 1]} ${picked.day.toString().padLeft(2, '0')}, ${picked.year}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFF0796DE),
      body: Column(children: [
        // ── Header ──────────────────────────────────────────────────
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
            Positioned(
                left: -20,
                bottom: -20,
                child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.06)))),
            Padding(
              padding: EdgeInsets.fromLTRB(8, topPadding + 8, 16, 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white, size: 24)),
                          GestureDetector(
                            onTap: _save,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Text('Save',
                                  style: TextStyle(
                                      color: Color(0xFF0796DE),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ]),
                    const SizedBox(height: 12),

                    // Avatar preview
                    Center(
                        child: Column(children: [
                      GestureDetector(
                        onTap: _showEmojiPicker,
                        child:
                            Stack(alignment: Alignment.bottomRight, children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _selectedEmoji.isEmpty
                                    ? _selectedColor
                                    : Colors.white.withOpacity(0.15),
                                border:
                                    Border.all(color: _selectedColor, width: 3),
                                boxShadow: [
                                  BoxShadow(
                                      color: _selectedColor.withOpacity(0.4),
                                      blurRadius: 20,
                                      offset: const Offset(0, 6))
                                ]),
                            child: Center(
                                child: _selectedEmoji.isEmpty
                                    ? const Icon(Icons.person_rounded,
                                        color: Colors.white, size: 46)
                                    : Text(_selectedEmoji,
                                        style: const TextStyle(fontSize: 44))),
                          ),
                          Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                  color: _selectedColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: const Color(0xFF0796DE),
                                      width: 2)),
                              child: const Icon(Icons.edit_rounded,
                                  color: Colors.white, size: 14)),
                        ]),
                      ),
                      const SizedBox(height: 8),
                      const Text('Tap to change avatar',
                          style: TextStyle(
                              color: Color(0xFFD0EEFF),
                              fontSize: 12,
                              fontFamily: 'Poppins')),
                    ])),
                  ]),
            ),
          ]),
        )),

        // ── Form ─────────────────────────────────────────────────────
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: Color(0xFFF5F7FA),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28))),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Personal details ──────────────────────────────────
                    const Text('Personal Details',
                        style: TextStyle(
                            color: Color(0xFF1A1A1A),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    _formCard([
                      _field('Full Name', _nameCtrl, Icons.person_rounded,
                          hint: 'Your full name'),
                      _field('Phone Number', _phoneCtrl, Icons.phone_rounded,
                          hint: 'e.g. 077 123 4567',
                          keyboard: TextInputType.phone),
                      _datePicker(),
                      _field('Address', _addressCtrl, Icons.location_on_rounded,
                          hint: 'e.g. Colombo, Sri Lanka'),
                    ]),

                    const SizedBox(height: 24),

                    // ── Profile colour ────────────────────────────────────
                    const Text('Profile Colour',
                        style: TextStyle(
                            color: Color(0xFF1A1A1A),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    const Text('Changes your avatar background colour',
                        style: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: 12,
                            fontFamily: 'Poppins')),
                    const SizedBox(height: 14),
                    Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _palette.map((c) {
                          final sel = c == _selectedColor;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedColor = c),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: c,
                                  border: Border.all(
                                      color: sel
                                          ? const Color(0xFF1A1A1A)
                                          : Colors.transparent,
                                      width: 3),
                                  boxShadow: sel
                                      ? [
                                          BoxShadow(
                                              color: c.withOpacity(0.5),
                                              blurRadius: 10,
                                              spreadRadius: 1)
                                        ]
                                      : []),
                              child: sel
                                  ? const Icon(Icons.check_rounded,
                                      color: Colors.white, size: 22)
                                  : null,
                            ),
                          );
                        }).toList()),

                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _save,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0796DE),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                            elevation: 4,
                            shadowColor:
                                const Color(0xFF0796DE).withOpacity(0.4)),
                        child: const Text('Save Changes',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _formCard(List<Widget> fields) => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4))
            ]),
        child: Column(
            children: List.generate(
                fields.length,
                (i) => Column(children: [
                      fields[i],
                      if (i < fields.length - 1)
                        Divider(
                            height: 1, indent: 56, color: Colors.grey.shade100),
                    ]))),
      );

  Widget _field(String label, TextEditingController ctrl, IconData icon,
      {String? hint, TextInputType? keyboard}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(children: [
        Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
                color: const Color(0xFF0796DE).withOpacity(0.10),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: const Color(0xFF0796DE), size: 17)),
        const SizedBox(width: 13),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label,
              style: const TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontSize: 11,
                  fontFamily: 'Poppins')),
          const SizedBox(height: 2),
          TextField(
            controller: ctrl,
            keyboardType: keyboard,
            style: const TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                    color: Color(0xFFCBD5E1),
                    fontSize: 13,
                    fontFamily: 'Poppins'),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.only(top: 4)),
          ),
        ])),
      ]),
    );
  }

  Widget _datePicker() => GestureDetector(
        onTap: _pickDate,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(children: [
            Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                    color: const Color(0xFF0796DE).withOpacity(0.10),
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.cake_rounded,
                    color: Color(0xFF0796DE), size: 17)),
            const SizedBox(width: 13),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const Text('Date of Birth',
                      style: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 11,
                          fontFamily: 'Poppins')),
                  const SizedBox(height: 2),
                  Text(_dobCtrl.text.isEmpty ? 'Tap to select' : _dobCtrl.text,
                      style: TextStyle(
                          color: _dobCtrl.text.isEmpty
                              ? const Color(0xFFCBD5E1)
                              : const Color(0xFF1E1E1E),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500)),
                ])),
            const Icon(Icons.chevron_right_rounded,
                color: Color(0xFFCBD5E1), size: 20),
          ]),
        ),
      );
}
