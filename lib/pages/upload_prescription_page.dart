import 'package:flutter/material.dart';
import 'animated_background.dart';
import 'upload_prescription_options_page.dart';

class UploadPrescriptionPage extends StatelessWidget {
  const UploadPrescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedBackground(),
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Upload Prescription',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFFAFAFA),
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                height: 1,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Upload your pharmacy to the system',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFA2E0FF),
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),

                const Spacer(),

                // White card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 33),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 15),
                        // Drag handle
                        Container(
                          width: 33,
                          height: 8,
                          decoration: BoxDecoration(
                            color: const Color(0xFFECEFEE),
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // MediFind Logo
                        SizedBox(
                          width: 163,
                          height: 91,
                          child: Image.asset(
                            'assets/images/Medifind_logo.png',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.medical_services,
                                    size: 50, color: const Color(0xFF0796DE)),
                                const Text(
                                  'MediFind',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF0796DE),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Description
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 46),
                          child: Text(
                            "Here's The portal for upload your prescription",
                            style: TextStyle(
                              color: Color(0xFF2D2D2D),
                              fontSize: 20,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w400,
                              height: 1,
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Upload Button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 39),
                          child: SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: ElevatedButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UploadPrescriptionOptionsPage(),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0796DE),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Upload',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 35),
                      ],
                    ),
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF0796DE),
      child: Stack(
        children: [
          Positioned(
            left: 37,
            top: -99,
            child: Container(
              width: 183,
              height: 183,
              decoration: const ShapeDecoration(
                shape: OvalBorder(
                    side: BorderSide(width: 30, color: Color(0xFF10A2EA))),
              ),
            ),
          ),
          Positioned(
            left: 130.01,
            top: 197.85,
            child: Opacity(
              opacity: 0.30,
              child: Container(
                transform: Matrix4.identity()..rotateZ(3.03),
                width: 153.81,
                height: 153.81,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.93, 0.35),
                    end: Alignment(0.06, 0.40),
                    colors: [Color(0xAFFDEDCA), Color(0xFF0A9BE2)],
                  ),
                  shape: OvalBorder(),
                ),
              ),
            ),
          ),
          Positioned(
            left: 32.30,
            top: 63,
            child: Opacity(
              opacity: 0.30,
              child: Container(
                transform: Matrix4.identity()..rotateZ(0.57),
                width: 89.35,
                height: 89.35,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.93, 0.35),
                    end: Alignment(0.06, 0.40),
                    colors: [Color(0xFFFDEDCA), Color(0xFF0A9BE2)],
                  ),
                  shape: OvalBorder(),
                ),
              ),
            ),
          ),
          Positioned(
            left: 110.98,
            top: 32.77,
            child: Opacity(
              opacity: 0.30,
              child: Container(
                transform: Matrix4.identity()..rotateZ(3.03),
                width: 94.08,
                height: 94.08,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.93, 0.35),
                    end: Alignment(0.06, 0.40),
                    colors: [Color(0xAFFDEDCA), Color(0xFF0A9BE2)],
                  ),
                  shape: OvalBorder(),
                ),
              ),
            ),
          ),
          Positioned(
            left: 310.47,
            top: 65.17,
            child: Container(
              transform: Matrix4.identity()..rotateZ(0.40),
              width: 167,
              height: 167,
              decoration: const ShapeDecoration(
                shape: OvalBorder(
                    side: BorderSide(width: 30, color: Color(0xFF10A2EA))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
