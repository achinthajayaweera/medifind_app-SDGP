import 'package:flutter/material.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage>
    with TickerProviderStateMixin {
  // Floating animations for circles
  late AnimationController _floatController1;
  late AnimationController _floatController2;
  late AnimationController _floatController3;
  late AnimationController _floatController4;

  late Animation<Offset> _floatAnimation1;
  late Animation<Offset> _floatAnimation2;
  late Animation<Offset> _floatAnimation3;
  late Animation<Offset> _floatAnimation4;

  @override
  void initState() {
    super.initState();

    // Floating animations for circles
    _floatController1 = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatController2 = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _floatController3 = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _floatController4 = AnimationController(
      duration: const Duration(seconds: 3, milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    // Different floating patterns for each circle
    _floatAnimation1 = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(25, -35),
    ).animate(
        CurvedAnimation(parent: _floatController1, curve: Curves.easeInOut));

    _floatAnimation2 = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(-20, 30),
    ).animate(
        CurvedAnimation(parent: _floatController2, curve: Curves.easeInOut));

    _floatAnimation3 = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(35, 20),
    ).animate(
        CurvedAnimation(parent: _floatController3, curve: Curves.easeInOut));

    _floatAnimation4 = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(-25, -30),
    ).animate(
        CurvedAnimation(parent: _floatController4, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _floatController1.dispose();
    _floatController2.dispose();
    _floatController3.dispose();
    _floatController4.dispose();
    super.dispose();
  }

  void _showUnderDevelopmentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Coming Soon',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Color(0xFF0796DE),
          ),
        ),
        content: const Text(
          'The "Add Reminder" feature is currently under development. Stay tuned for updates!',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Color(0xFF0796DE),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Blue gradient background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF0796DE),
            ),
          ),

          // Floating decorative circles
          _buildDecorativeCircles(),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Top padding
                const SizedBox(height: 40),

                // Title
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'A healthy day\nWe\'ll take care of you',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Sample reminder cards
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        _buildReminderCard(
                          title: 'Drink Water',
                          times: ['8:00 AM', '1:00 PM', '7:00 PM'],
                        ),
                        const SizedBox(height: 16),
                        _buildReminderCard(
                          title: 'Take Vitamins',
                          times: ['9:00 AM'],
                        ),
                        const SizedBox(height: 16),
                        _buildReminderCard(
                          title: 'Blood Pressure Check',
                          times: ['8:00 AM', '8:00 PM'],
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom "Add Reminder" button
          Positioned(
            left: 24,
            right: 24,
            bottom: 40,
            child: ElevatedButton(
              onPressed: _showUnderDevelopmentDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                shadowColor: Colors.black.withOpacity(0.3),
              ),
              child: const Text(
                'Add Reminder',
                style: TextStyle(
                  color: Color(0xFF0796DE),
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderCard(
      {required String title, required List<String> times}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF0796DE),
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          // Times
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: times
                .map((time) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0796DE).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF0796DE).withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        time,
                        style: const TextStyle(
                          color: Color(0xFF0796DE),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeCircles() {
    return Stack(
      children: [
        // Circle 1 - Top left
        AnimatedBuilder(
          animation: _floatAnimation1,
          builder: (context, child) {
            final offset = _floatAnimation1.value;
            return Positioned(
              left: 30 + offset.dx,
              top: 80 + offset.dy,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 20, color: const Color(0xFF10A2EA)),
                ),
              ),
            );
          },
        ),

        // Circle 2 - Top right
        AnimatedBuilder(
          animation: _floatAnimation2,
          builder: (context, child) {
            final offset = _floatAnimation2.value;
            return Positioned(
              right: 20 + offset.dx,
              top: 120 + offset.dy,
              child: Opacity(
                opacity: 0.30,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: const Alignment(0.93, 0.35),
                      end: const Alignment(0.06, 0.40),
                      colors: [
                        const Color(0xAFFDEDCA),
                        const Color(0xFF0A9BE2)
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        // Circle 3 - Middle
        AnimatedBuilder(
          animation: _floatAnimation3,
          builder: (context, child) {
            final offset = _floatAnimation3.value;
            return Positioned(
              left: MediaQuery.of(context).size.width / 2 - 60 + offset.dx,
              top: MediaQuery.of(context).size.height / 2 - 60 + offset.dy,
              child: Opacity(
                opacity: 0.20,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: const Alignment(0.93, 0.35),
                      end: const Alignment(0.06, 0.40),
                      colors: [
                        const Color(0xFFFDEDCA),
                        const Color(0xFF0A9BE2)
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        // Circle 4 - Bottom right
        AnimatedBuilder(
          animation: _floatAnimation4,
          builder: (context, child) {
            final offset = _floatAnimation4.value;
            return Positioned(
              right: 40 + offset.dx,
              bottom: 150 + offset.dy,
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 20, color: const Color(0xFF10A2EA)),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
