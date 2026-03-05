import 'dart:math';
import 'package:flutter/material.dart';
import 'registration_state.dart';
import 'doc_verification_success_page.dart';
import 'doc_verification_pending_page.dart';
import 'doc_verification_failed_page.dart';

class CameraCapturePage extends StatefulWidget {
  const CameraCapturePage({super.key});

  @override
  State<CameraCapturePage> createState() => _CameraCapturePageState();
}

class _CameraCapturePageState extends State<CameraCapturePage> {
  bool _flashOn = false;

  void _onCapture() {
    _showUploadDialog();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pop(context); // close dialog

      // Pick random result for demo; replace with real API result later
      final result = Random().nextInt(3);
      RegistrationStatus status;
      Widget page;

      if (result == 0) {
        status = RegistrationStatus.success;
        page = const DocVerificationSuccessPage();
      } else if (result == 1) {
        status = RegistrationStatus.pending;
        page = const DocVerificationPendingPage();
      } else {
        status = RegistrationStatus.failed;
        page = const DocVerificationFailedPage();
      }

      // Save the submission status globally
      RegistrationState().setStatus(status);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    });
  }

  void _showUploadDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 30),
            decoration: BoxDecoration(
              color: const Color(0xFF0796DE),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
                SizedBox(height: 18),
                Text(
                  'Uploading document...',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Please wait a moment',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    color: Color(0xFFA2E0FF),
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, 0.00),
            end: Alignment(1.00, 1.00),
            colors: [Color(0xFF354152), Color(0xFF101727)],
          ),
        ),
        child: Stack(
          children: [
            // Top gradient — covers full top
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.75),
                      Colors.black.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),

            // Camera viewfinder frame
            Positioned(
              left: 22,
              top: 130,
              right: 22,
              bottom: 168,
              child: Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 1.48, color: Color(0x66FFFEFE)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            // "Align Registration within frame" pill — centered
            Positioned(
              left: 0,
              right: 0,
              top: 100,
              child: Center(
                child: IntrinsicWidth(
                  child: Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: ShapeDecoration(
                      color: Colors.black.withOpacity(0.70),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Align Registration within frame',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Arimo',
                          fontWeight: FontWeight.w400,
                          height: 1.43,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Bottom gradient + capture button + label
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                height: 168,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.60),
                      Colors.black.withOpacity(0),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Capture button — centered
                    GestureDetector(
                      onTap: _onCapture,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(
                                width: 3.70, color: Color(0xFF11A2EB)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 6,
                              offset: Offset(0, 4),
                              spreadRadius: -4,
                            ),
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 15,
                              offset: Offset(0, 10),
                              spreadRadius: -3,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: const ShapeDecoration(
                              color: Color(0xFF11A2EB),
                              shape: OvalBorder(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Tap to capture Registration',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xCCFFFEFE),
                        fontSize: 12,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Top bar — back + title + flash
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: SizedBox(
                  height: 58,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: Colors.black.withOpacity(0.40),
                            shape: const OvalBorder(),
                          ),
                          child: const Icon(Icons.arrow_back,
                              color: Colors.white, size: 20),
                        ),
                      ),
                      const Text(
                        'Take Photo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFFAFAFA),
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _flashOn = !_flashOn),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: Colors.black.withOpacity(0.40),
                            shape: const OvalBorder(),
                          ),
                          child: Icon(
                            _flashOn ? Icons.flash_on : Icons.flash_off,
                            color: _flashOn
                                ? const Color(0xFF11A2EB)
                                : Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
