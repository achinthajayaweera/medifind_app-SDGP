import 'package:flutter/material.dart';

class PharmacyDetailPage extends StatelessWidget {
  final Map<String, dynamic> pharmacy;

  const PharmacyDetailPage({super.key, required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pharmacy['name'] ?? 'Pharmacy Details'),
        backgroundColor: const Color(0xFF0796DE),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pharmacy Name
            Text(
              pharmacy['name'] ?? 'Unknown Pharmacy',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),

            // Distance
            Row(
              children: [
                const Icon(Icons.location_on,
                    size: 20, color: Color(0xFF0796DE)),
                const SizedBox(width: 4),
                Text(
                  pharmacy['distance'] ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // Details Section
            _buildDetailRow('Address', pharmacy['address'] ?? 'Not available'),
            const SizedBox(height: 12),
            _buildDetailRow('Phone', pharmacy['phone'] ?? 'Not available'),
            const SizedBox(height: 12),
            _buildDetailRow('Hours', pharmacy['hours'] ?? 'Not available'),
            const SizedBox(height: 12),
            _buildDetailRow('Rating', pharmacy['rating']?.toString() ?? 'N/A'),

            const SizedBox(height: 24),

            // Call Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement call functionality
                },
                icon: const Icon(Icons.phone),
                label: const Text('Call Pharmacy'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0796DE),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Get Directions Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement directions functionality
                },
                icon: const Icon(Icons.directions),
                label: const Text('Get Directions'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0796DE),
                  side: const BorderSide(color: Color(0xFF0796DE)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }
}
