import 'package:flutter/material.dart';

class UploadPrescriptionPage extends StatefulWidget {
  const UploadPrescriptionPage({super.key});

  @override
  State<UploadPrescriptionPage> createState() => _UploadPrescriptionPageState();
}

class _UploadPrescriptionPageState extends State<UploadPrescriptionPage>
    with TickerProviderStateMixin {
  final _otpController = TextEditingController();
  final _scrollController = ScrollController();

  // 0 = none selected, 1 = photo/gallery, 2 = manual
  int _selectedMethod = 0;
  String? _uploadedFileName;

  // Manual entry
  final List<_MedicineEntry> _medicines = [_MedicineEntry()];

  late AnimationController _slideController;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _slideController, curve: Curves.easeOutCubic));
    _slideController.forward();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _scrollController.dispose();
    _slideController.dispose();
    for (final e in _medicines) e.dispose();
    super.dispose();
  }

  void _selectMethod(int method) {
    setState(() => _selectedMethod = method);
    if (method == 2) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
      });
    }
  }

  void _addMedicine() {
    setState(() => _medicines.add(_MedicineEntry()));
    Future.delayed(const Duration(milliseconds: 200), () {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  void _removeMedicine(int index) {
    if (_medicines.length == 1) return;
    _medicines[index].dispose();
    setState(() => _medicines.removeAt(index));
  }

  void _submit() {
    final otp = _otpController.text.trim();
    if (_selectedMethod == 0) {
      _showSnack('Please choose an upload method', isError: true);
      return;
    }
    if (otp.isEmpty) {
      _showSnack('Please enter the doctor-issued OTP', isError: true);
      return;
    }
    if (otp.length < 4) {
      _showSnack('OTP must be at least 4 characters', isError: true);
      return;
    }
    if (_selectedMethod == 2) {
      final empty = _medicines.any((e) => e.nameCtrl.text.trim().isEmpty);
      if (empty) {
        _showSnack('Please fill in all medicine names', isError: true);
        return;
      }
    }
    if (_selectedMethod == 1 && _uploadedFileName == null) {
      _showSnack('Please take a photo or upload from gallery', isError: true);
      return;
    }
    _showSnack('Prescription submitted successfully!', isError: false);
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) Navigator.pop(context);
    });
  }

  void _showSnack(String msg, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg,
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 13)),
      backgroundColor:
          isError ? const Color(0xFFEF5350) : const Color(0xFF4CAF50),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFF0796DE),
      body: Column(
        children: [
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
                    bottom: -10,
                    child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.06)))),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, topPadding + 8, 16, 20),
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
                              const SizedBox(width: 48),
                            ]),
                        const SizedBox(height: 4),
                        const Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Upload Prescription',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700)),
                                SizedBox(height: 2),
                                Text(
                                    'Upload a photo or enter medicines manually',
                                    style: TextStyle(
                                        color: Color(0xFFD0EEFF),
                                        fontSize: 12,
                                        fontFamily: 'Poppins')),
                              ]),
                        ),
                      ]),
                ),
              ]),
            ),
          ),

          // ── Content ──────────────────────────────────────────────────
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0xFFF5F7FF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28))),
              child: SlideTransition(
                position: _slideAnim,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // drag handle
                        Center(
                            child: Container(
                                width: 36,
                                height: 4,
                                decoration: BoxDecoration(
                                    color: const Color(0xFFCDD5E0),
                                    borderRadius: BorderRadius.circular(2)))),
                        const SizedBox(height: 20),

                        // ── Section: Upload options ────────────────────────
                        _sectionLabel('Choose Upload Method'),
                        const SizedBox(height: 12),

                        // Take Photo
                        _UploadOption(
                          icon: Icons.camera_alt_rounded,
                          label: 'Take Photo',
                          subtitle: 'Capture your prescription with camera',
                          selected: _selectedMethod == 1,
                          onTap: () {
                            _selectMethod(1);
                            setState(() =>
                                _uploadedFileName = 'prescription_photo.jpg');
                          },
                        ),
                        const SizedBox(height: 10),

                        // Upload from gallery
                        _UploadOption(
                          icon: Icons.photo_library_rounded,
                          label: 'Upload From Gallery',
                          subtitle: 'Select an existing image from your phone',
                          selected: _selectedMethod == 1 &&
                              _uploadedFileName != null &&
                              _uploadedFileName!.contains('gallery'),
                          onTap: () {
                            _selectMethod(1);
                            setState(() =>
                                _uploadedFileName = 'gallery_prescription.jpg');
                          },
                        ),
                        const SizedBox(height: 10),

                        // Manual entry
                        _UploadOption(
                          icon: Icons.edit_note_rounded,
                          label: 'Enter Manually',
                          subtitle: 'Type medicine names and dosages yourself',
                          selected: _selectedMethod == 2,
                          onTap: () => _selectMethod(2),
                          accentColor: const Color(0xFF7C3AED),
                        ),

                        // Uploaded file indicator
                        if (_selectedMethod == 1 &&
                            _uploadedFileName != null) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                                color: const Color(0xFF4CAF50).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: const Color(0xFF4CAF50)
                                        .withOpacity(0.3))),
                            child: Row(children: [
                              const Icon(Icons.check_circle_rounded,
                                  color: Color(0xFF4CAF50), size: 18),
                              const SizedBox(width: 8),
                              Expanded(
                                  child: Text(_uploadedFileName!,
                                      style: const TextStyle(
                                          color: Color(0xFF4CAF50),
                                          fontSize: 13,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500))),
                              GestureDetector(
                                onTap: () =>
                                    setState(() => _uploadedFileName = null),
                                child: const Icon(Icons.close_rounded,
                                    color: Color(0xFF4CAF50), size: 16),
                              ),
                            ]),
                          ),
                        ],

                        // ── Manual entry section (animated) ────────────────
                        AnimatedSize(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeOutCubic,
                          child: _selectedMethod == 2
                              ? _buildManualSection()
                              : const SizedBox.shrink(),
                        ),

                        const SizedBox(height: 24),

                        // ── OTP field ──────────────────────────────────────
                        _sectionLabel('Prescription Authentication Code (OTP)'),
                        const SizedBox(height: 8),
                        _buildOtpField(),
                        const SizedBox(height: 6),
                        Text(
                            'This code is provided by your doctor to verify authenticity.',
                            style: TextStyle(
                                color: const Color(0xFF64748B).withOpacity(0.8),
                                fontSize: 11,
                                fontFamily: 'Poppins')),

                        const SizedBox(height: 24),

                        // ── Guidelines ─────────────────────────────────────
                        _buildGuidelines(),

                        const SizedBox(height: 24),

                        // ── Privacy note ────────────────────────────────────
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                              color: const Color(0xFF0796DE).withOpacity(0.07),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                  color: const Color(0xFF0796DE)
                                      .withOpacity(0.15))),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('🔒 ',
                                    style: TextStyle(fontSize: 14)),
                                Expanded(
                                    child: RichText(
                                  text: const TextSpan(children: [
                                    TextSpan(
                                        text: 'Privacy Protected: ',
                                        style: TextStyle(
                                            color: Color(0xFF0796DE),
                                            fontSize: 13,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text:
                                            'Your prescription data is encrypted and securely stored.',
                                        style: TextStyle(
                                            color: Color(0xFF334155),
                                            fontSize: 12,
                                            fontFamily: 'Poppins')),
                                  ]),
                                )),
                              ]),
                        ),
                        const SizedBox(height: 24),

                        // ── Continue button ────────────────────────────────
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0796DE),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                elevation: 4,
                                shadowColor:
                                    const Color(0xFF0796DE).withOpacity(0.4)),
                            child: const Text('Continue',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700)),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Need help
                        Center(
                            child: Column(children: [
                          Text('Need help uploading?',
                              style: TextStyle(
                                  color:
                                      const Color(0xFF64748B).withOpacity(0.8),
                                  fontSize: 12,
                                  fontFamily: 'Poppins')),
                          const SizedBox(height: 2),
                          GestureDetector(
                            onTap: () {},
                            child: const Text('Contact Support',
                                style: TextStyle(
                                    color: Color(0xFF0796DE),
                                    fontSize: 13,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFF0796DE))),
                          ),
                        ])),
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManualSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _sectionLabel('Medicines'),
        GestureDetector(
          onTap: _addMedicine,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
                color: const Color(0xFF0796DE),
                borderRadius: BorderRadius.circular(20)),
            child: const Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.add_rounded, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Text('Add',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600)),
            ]),
          ),
        ),
      ]),
      const SizedBox(height: 10),
      ...List.generate(
          _medicines.length,
          (i) => _MedicineEntryCard(
                entry: _medicines[i],
                index: i,
                canRemove: _medicines.length > 1,
                onRemove: () => _removeMedicine(i),
              )),
    ]);
  }

  Widget _buildOtpField() {
    return TextField(
      controller: _otpController,
      keyboardType: TextInputType.text,
      style: const TextStyle(
          color: Color(0xFF0F172A),
          fontSize: 14,
          fontFamily: 'Poppins',
          letterSpacing: 2),
      decoration: InputDecoration(
        hintText: 'Enter doctor-issued OTP...',
        hintStyle: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 13,
            fontFamily: 'Poppins',
            letterSpacing: 0),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.lock_outline_rounded,
            color: Color(0xFF0796DE), size: 20),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF0796DE), width: 1.5)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildGuidelines() {
    final items = [
      'Ensure prescription is clear and readable',
      'Prescription must be issued within the last 6 months',
      "Doctor's signature and stamp must be visible",
      'Patient name and date should be clearly visible',
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionLabel('Important Guidelines'),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xFF0796DE).withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3))
            ]),
        child: Column(
            children: items
                .map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 6,
                                height: 6,
                                margin:
                                    const EdgeInsets.only(top: 5, right: 10),
                                decoration: const BoxDecoration(
                                    color: Color(0xFF0796DE),
                                    shape: BoxShape.circle)),
                            Expanded(
                                child: Text(item,
                                    style: const TextStyle(
                                        color: Color(0xFF334155),
                                        fontSize: 13,
                                        fontFamily: 'Poppins'))),
                          ]),
                    ))
                .toList()),
      ),
    ]);
  }

  Widget _sectionLabel(String text) => Text(text,
      style: const TextStyle(
          color: Color(0xFF0F172A),
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600));
}

// ── Upload option card ─────────────────────────────────────────────────────────
class _UploadOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;
  final Color accentColor;

  const _UploadOption({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.selected,
    required this.onTap,
    this.accentColor = const Color(0xFF0796DE),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
            color: selected ? accentColor.withOpacity(0.06) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: selected ? accentColor : const Color(0xFFE2E8F0),
                width: selected ? 2 : 1),
            boxShadow: selected
                ? [
                    BoxShadow(
                        color: accentColor.withOpacity(0.12),
                        blurRadius: 12,
                        offset: const Offset(0, 3))
                  ]
                : [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2))
                  ]),
        child: Row(children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: selected ? accentColor : accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14)),
            child: Icon(icon,
                color: selected ? Colors.white : accentColor, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(label,
                    style: TextStyle(
                        color: selected ? accentColor : const Color(0xFF0F172A),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 11,
                        fontFamily: 'Poppins')),
              ])),
          if (selected)
            Icon(Icons.check_circle_rounded, color: accentColor, size: 22),
        ]),
      ),
    );
  }
}

// ── Medicine entry data ────────────────────────────────────────────────────────
class _MedicineEntry {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController dosageCtrl = TextEditingController();
  final TextEditingController qtyCtrl = TextEditingController();

  void dispose() {
    nameCtrl.dispose();
    dosageCtrl.dispose();
    qtyCtrl.dispose();
  }
}

// ── Medicine entry card ────────────────────────────────────────────────────────
class _MedicineEntryCard extends StatelessWidget {
  final _MedicineEntry entry;
  final int index;
  final bool canRemove;
  final VoidCallback onRemove;

  const _MedicineEntryCard({
    required this.entry,
    required this.index,
    required this.canRemove,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Header row
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
                color: const Color(0xFF0796DE).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)),
            child: Text('Medicine ${index + 1}',
                style: const TextStyle(
                    color: Color(0xFF0796DE),
                    fontSize: 11,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600)),
          ),
          if (canRemove)
            GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                    color: const Color(0xFFEF5350).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.remove_rounded,
                    color: Color(0xFFEF5350), size: 16),
              ),
            ),
        ]),
        const SizedBox(height: 12),

        // Medicine name
        _fieldLabel('Medicine Name *'),
        const SizedBox(height: 6),
        _buildField(
            entry.nameCtrl, 'e.g. Paracetamol 500mg', Icons.medication_rounded),
        const SizedBox(height: 10),

        // Dosage + Quantity row
        Row(children: [
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                _fieldLabel('Dosage'),
                const SizedBox(height: 6),
                _buildField(entry.dosageCtrl, 'e.g. 2x daily',
                    Icons.access_time_rounded),
              ])),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                _fieldLabel('Quantity'),
                const SizedBox(height: 6),
                _buildField(entry.qtyCtrl, 'e.g. 10 tablets',
                    Icons.production_quantity_limits_rounded,
                    keyboardType: TextInputType.number),
              ])),
        ]),
      ]),
    );
  }

  Widget _fieldLabel(String text) => Text(text,
      style: const TextStyle(
          color: Color(0xFF475569),
          fontSize: 11,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500));

  Widget _buildField(TextEditingController ctrl, String hint, IconData icon,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboardType,
      style: const TextStyle(
          color: Color(0xFF0F172A), fontSize: 13, fontFamily: 'Poppins'),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
            color: Color(0xFF94A3B8), fontSize: 12, fontFamily: 'Poppins'),
        prefixIcon: Icon(icon, color: const Color(0xFF0796DE), size: 18),
        prefixIconConstraints: const BoxConstraints(minWidth: 40),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF0796DE), width: 1.5)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      ),
    );
  }
}
