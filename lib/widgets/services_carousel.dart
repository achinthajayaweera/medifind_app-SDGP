import 'package:flutter/material.dart';
import '../pages/all_services_page.dart';
import '../pages/upload_prescription_main_page.dart';
import '../pages/reminder_page.dart';
import '../pages/pharmacy_registration_page.dart';

class ServicesCarousel extends StatelessWidget {
  const ServicesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'More Services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllServicesPage(),
                    ),
                  );
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: Color(0xFF0796DE),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
        ),
        // Services carousel
        SizedBox(
          height: 180, // Increased from 155 to accommodate bigger icons
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildServiceItem(
                context: context,
                imagePath: 'assets/images/Upload_icon.png',
                label: 'Upload\nprescription',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UploadPrescriptionMainPage(),
                    ),
                  );
                },
              ),
              _buildServiceItem(
                context: context,
                imagePath: 'assets/images/reminder.png',
                label: 'reminder',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReminderPage(),
                    ),
                  );
                },
              ),
              _buildServiceItem(
                context: context,
                imagePath: 'assets/images/Past_orders.png',
                label: 'past\norders',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReminderPage(),
                    ),
                  );
                },
              ),
              _buildServiceItem(
                context: context,
                imagePath: 'assets/images/profile.png',
                label: 'View Your\nAccount',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReminderPage(),
                    ),
                  );
                },
              ),
              _buildServiceItem(
                context: context,
                imagePath: 'assets/images/pharmacy_register.png',
                label: 'Pharmacy\nRegistration',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PharmacyRegistrationPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceItem({
    required BuildContext context,
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 115, // Increased from 100 to accommodate bigger icon
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            // Custom PNG Image - Full rounded corners without white border
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit
                      .cover, // Changed back to cover since images have their own background
                  errorBuilder: (context, error, stackTrace) {
                    print('❌ Failed to load: $imagePath');
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(
                        _getFallbackIcon(label),
                        size: 40,
                        color: const Color(0xFF0796DE),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Label
            SizedBox(
              height: 42,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getFallbackIcon(String label) {
    if (label.contains('Upload')) return Icons.upload_file;
    if (label.contains('reminder')) return Icons.alarm;
    if (label.contains('past')) return Icons.history;
    if (label.contains('Account')) return Icons.person;
    if (label.contains('Pharmacy')) return Icons.store;
    return Icons.apps;
  }
}
