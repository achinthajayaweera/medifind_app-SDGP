import 'package:flutter/material.dart';
import 'dart:async';

class TermsOfServicesPage extends StatefulWidget {
  const TermsOfServicesPage({super.key});

  @override
  State<TermsOfServicesPage> createState() => _TermsOfServicesPageState();
}

class _TermsOfServicesPageState extends State<TermsOfServicesPage>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  final ScrollController _scrollController = ScrollController();
  bool _hasScrolledToBottom = false;
  bool _acceptedTerms = false;
  bool _canPressAccept = false;

  @override
  void initState() {
    super.initState();

    // Slide up animation for white card
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.0), // Start from bottom
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Fade in animation for title
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    // Listen to scroll
    _scrollController.addListener(_onScroll);

    // Start animations
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _slideController.forward();

    await Future.delayed(const Duration(milliseconds: 400));
    _fadeController.forward();
  }

  void _onScroll() {
    // Check if scrolled to bottom
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent - 10) {
      if (!_hasScrolledToBottom) {
        setState(() {
          _hasScrolledToBottom = true;
        });
      }
    }

    // Update button state
    setState(() {
      _canPressAccept = _hasScrolledToBottom && _acceptedTerms;
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF0796DE),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Title at top with fade animation
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 20),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'Terms of Services',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              // White card slides up from bottom
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 33),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        // Drag handle
                        Container(
                          width: 33,
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFFECEFEE),
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // MediFind logo
                        Image.asset(
                          'assets/images/Medifind_logo.png',
                          width: 107,
                          height: 59,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 107,
                              height: 59,
                              color: const Color(0xFF0796DE),
                              child: const Icon(
                                Icons.medical_services,
                                color: Colors.white,
                                size: 30,
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        // Scrollable terms
                        Expanded(
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                              children: [
                                const Text(
                                  _termsText,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF2D2D2D),
                                    fontSize: 14,
                                    fontFamily: 'Arimo',
                                    fontWeight: FontWeight.w400,
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 30),

                                // Checkbox at bottom
                                AnimatedOpacity(
                                  opacity: _hasScrolledToBottom ? 1.0 : 0.3,
                                  duration: const Duration(milliseconds: 300),
                                  child: InkWell(
                                    onTap: _hasScrolledToBottom
                                        ? () {
                                            setState(() {
                                              _acceptedTerms = !_acceptedTerms;
                                            });
                                          }
                                        : null,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Checkbox(
                                          value: _acceptedTerms,
                                          onChanged: _hasScrolledToBottom
                                              ? (value) {
                                                  setState(() {
                                                    _acceptedTerms =
                                                        value ?? false;
                                                  });
                                                }
                                              : null,
                                          activeColor: const Color(0xFF0796DE),
                                        ),
                                        const Flexible(
                                          child: Text(
                                            'I accept the terms and conditions',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'Arimo',
                                              color: Color(0xFF2D2D2D),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),

                        // Accept button
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: _canPressAccept
                                ? () {
                                    Navigator.pushReplacementNamed(
                                        context, '/welcome');
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0796DE),
                              disabledBackgroundColor: Colors.grey.shade300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Accept',
                              style: TextStyle(
                                color: _canPressAccept
                                    ? Colors.white
                                    : Colors.grey.shade500,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  static const String _termsText =
      '''By accessing and using the MediFind mobile application, you agree to comply with and be bound by these Terms of Service. If you do not agree with these terms, you may not access or use the application.

MediFind is a digital platform that allows users to upload prescriptions, search for nearby pharmacies, check medicine availability, manage medicine reminders, and place medicine-related orders.

The system may use Optical Character Recognition (OCR) technology and other automated tools to extract text and information from uploaded prescription images. While MediFind utilizes digital processing technologies to improve convenience and efficiency, we do not guarantee one hundred percent accuracy of extracted prescription details.

Users are responsible for carefully reviewing and confirming all prescription information before placing any orders. Pharmacies using the platform are responsible for verifying prescriptions in accordance with applicable medical standards and regulations before dispensing medication.

Users agree to provide accurate and truthful information, upload only valid and legally obtained prescriptions, and use the application strictly for lawful medical purposes. Any misuse of the platform, including submitting false information or attempting to disrupt the system, may result in suspension or termination of access.

Pharmacies registering on the MediFind platform must submit accurate registration details and valid licensing documentation for verification. MediFind reserves the right to review, approve, or reject pharmacy registrations at its discretion.

MediFind is committed to protecting user privacy. Prescription images and personal information are securely processed and stored solely for service-related purposes. Data will not be shared with unauthorized third parties except where required by law or with user consent.

MediFind operates as an intermediary platform connecting users and pharmacies and is not responsible for incorrect medication dispensed by pharmacies, delays in order processing or delivery, or errors resulting from unclear or incomplete prescription uploads.

Users are encouraged to consult qualified healthcare professionals for medical advice. MediFind reserves the right to modify, suspend, or discontinue any part of the service at any time. Continued use of the application indicates acceptance of these terms.''';
}
