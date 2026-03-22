import 'package:flutter/material.dart';

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});
  @override
  State<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  final _msgCtrl = TextEditingController();
  int? _expandedFaq;

  final _faqs = [
    (
      'How do I upload a prescription?',
      'Tap "Upload Prescription" from the home screen. You can take a photo, upload from gallery, or enter medicines manually. An OTP from your doctor is required.'
    ),
    (
      'How does order tracking work?',
      'After payment, tap "Track Order" on the success screen. You\'ll see a live map with your courier\'s location updating in real time.'
    ),
    (
      'Can I cancel an order?',
      'Orders can be cancelled within 5 minutes of placing them. Contact support immediately if you need to cancel.'
    ),
    (
      'How is the 3% MediFind fee calculated?',
      'MediFind adds a 3% processing fee to your order total to cover platform costs. This is shown clearly before you pay.'
    ),
    (
      'How do I set medicine reminders?',
      'Go to the Reminder tab from the bottom navigation. Add your medicine name, dosage, and schedule your reminder times.'
    ),
    (
      'Is my data secure?',
      'Yes. All prescription data is encrypted and stored securely. We never sell your personal information.'
    ),
  ];

  @override
  void dispose() {
    _msgCtrl.dispose();
    super.dispose();
  }

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
                    ]),
                    const SizedBox(height: 4),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Help & Support',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700)),
                            Text('We\'re here to help you',
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
                    // Quick contact cards
                    Row(children: [
                      Expanded(
                          child: _contactCard(
                              Icons.chat_rounded,
                              'Live Chat',
                              'Chat with us',
                              const Color(0xFF0796DE),
                              () => _showSnack('Opening chat...'))),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _contactCard(
                              Icons.email_rounded,
                              'Email Us',
                              'support@medifind.com',
                              const Color(0xFF7C3AED),
                              () => _showSnack('Opening email...'))),
                    ]),
                    const SizedBox(height: 12),
                    Row(children: [
                      Expanded(
                          child: _contactCard(
                              Icons.call_rounded,
                              'Call Us',
                              '+94 11 234 5678',
                              const Color(0xFF4CAF50),
                              () => _showSnack('Calling support...'))),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _contactCard(
                              Icons.article_rounded,
                              'User Guide',
                              'Read the docs',
                              const Color(0xFFFF9800),
                              () => _showSnack('Opening guide...'))),
                    ]),

                    const SizedBox(height: 28),

                    // FAQs
                    const Text('Frequently Asked Questions',
                        style: TextStyle(
                            color: Color(0xFF0F172A),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    const Color(0xFF0796DE).withOpacity(0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 3))
                          ]),
                      child: Column(
                          children: List.generate(_faqs.length, (i) {
                        final faq = _faqs[i];
                        final expanded = _expandedFaq == i;
                        return Column(children: [
                          GestureDetector(
                            onTap: () => setState(
                                () => _expandedFaq = expanded ? null : i),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              child: Row(children: [
                                Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF0796DE)
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                        child: Text('Q',
                                            style: const TextStyle(
                                                color: Color(0xFF0796DE),
                                                fontSize: 13,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700)))),
                                const SizedBox(width: 12),
                                Expanded(
                                    child: Text(faq.$1,
                                        style: TextStyle(
                                            color: expanded
                                                ? const Color(0xFF0796DE)
                                                : const Color(0xFF0F172A),
                                            fontSize: 13,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600))),
                                AnimatedRotation(
                                  turns: expanded ? 0.5 : 0,
                                  duration: const Duration(milliseconds: 250),
                                  child: Icon(Icons.keyboard_arrow_down_rounded,
                                      color: expanded
                                          ? const Color(0xFF0796DE)
                                          : const Color(0xFF94A3B8)),
                                ),
                              ]),
                            ),
                          ),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutCubic,
                            child: expanded
                                ? Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        60, 0, 16, 14),
                                    child: Text(faq.$2,
                                        style: const TextStyle(
                                            color: Color(0xFF64748B),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            height: 1.5)),
                                  )
                                : const SizedBox.shrink(),
                          ),
                          if (i < _faqs.length - 1)
                            const Divider(
                                height: 1,
                                indent: 16,
                                endIndent: 16,
                                color: Color(0xFFF1F5F9)),
                        ]);
                      })),
                    ),

                    const SizedBox(height: 28),

                    // Send message
                    const Text('Send us a Message',
                        style: TextStyle(
                            color: Color(0xFF0F172A),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    const Color(0xFF0796DE).withOpacity(0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 3))
                          ]),
                      child: Column(children: [
                        TextField(
                          controller: _msgCtrl,
                          maxLines: 4,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              color: Color(0xFF0F172A)),
                          decoration: InputDecoration(
                            hintText: 'Describe your issue or question...',
                            hintStyle: const TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 13,
                                fontFamily: 'Poppins'),
                            filled: true,
                            fillColor: const Color(0xFFF8FAFC),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Color(0xFFE2E8F0))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Color(0xFF0796DE), width: 1.5)),
                            contentPadding: const EdgeInsets.all(14),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_msgCtrl.text.trim().isEmpty) {
                                _showSnack('Please enter a message');
                                return;
                              }
                              _msgCtrl.clear();
                              _showSnack(
                                  'Message sent! We\'ll reply within 24 hours.');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0796DE),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                elevation: 0),
                            child: const Text('Send Message',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ]),
                    ),
                  ]),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _contactCard(IconData icon, String title, String sub, Color color,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2))
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color, size: 22)),
          const SizedBox(height: 10),
          Text(title,
              style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(sub,
              style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 11,
                  fontFamily: 'Poppins')),
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
}
