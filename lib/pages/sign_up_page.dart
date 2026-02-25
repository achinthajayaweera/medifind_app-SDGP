import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  bool _rememberMe = true;
  bool _obscurePassword = true;
  bool _obscureRePassword = true;

  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Slide up animation for blue card
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Start animation
    _slideController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Decorative circles on white background
          _buildDecorativeCircles(),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Top section with back button, logo, and title
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button and logo row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back, size: 24),
                            color: const Color(0xFF0A2C8B),
                          ),
                          Image.asset(
                            'assets/images/New logo VERT 1.png',
                            width: 132,
                            height: 74,
                            errorBuilder: (context, error, stackTrace) {
                              return const Text(
                                'MediFind',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0796DE),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Title
                      const SizedBox(
                        width: 212,
                        child: Text(
                          'Create Your\nFree Account',
                          style: TextStyle(
                            color: Color(0xFF0A2C8B),
                            fontSize: 32,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 1.1,
                            letterSpacing: -0.32,
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Subtitle
                      const SizedBox(
                        width: 184,
                        child: Text(
                          'Join thousands of users finding\ntheir medications with us.',
                          style: TextStyle(
                            color: Color(0xFF034A83),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Sliding dark blue card
                Expanded(
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFF001D70),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Drag handle
                            Center(
                              child: Container(
                                width: 30,
                                height: 9,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color(0xFF979797)),
                                ),
                              ),
                            ),

                            const SizedBox(height: 22),

                            // Email field
                            const Text(
                              'Email',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                height: 1.10,
                                letterSpacing: -0.36,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _emailController,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Abimanyu@onpoint.com',
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 12,
                                ),
                                filled: false,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 16),
                              ),
                            ),

                            const SizedBox(height: 18),

                            // Password field
                            const Text(
                              'Password',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                height: 1.10,
                                letterSpacing: -0.36,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                              decoration: InputDecoration(
                                filled: false,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 16),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            // Re-Enter Password field
                            const Text(
                              'Re-Enter Password',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                height: 1.10,
                                letterSpacing: -0.36,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _rePasswordController,
                              obscureText: _obscureRePassword,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                              decoration: InputDecoration(
                                filled: false,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 16),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureRePassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureRePassword = !_obscureRePassword;
                                    });
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Remember me
                            Row(
                              children: [
                                SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: Checkbox(
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
                                      });
                                    },
                                    fillColor: WidgetStateProperty.all(
                                        const Color(0xFF2196F3)),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2)),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  'Remember me',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.10,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 22),

                            // Sign Up button
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Navigate to home
                                  Navigator.pushReplacementNamed(
                                      context, '/home');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2196F3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  elevation: 4,
                                  shadowColor: Colors.black.withOpacity(0.2),
                                ),
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.12,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Or divider
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                        height: 1, color: Colors.white)),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    'Or',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                        height: 1, color: Colors.white)),
                              ],
                            ),

                            const SizedBox(height: 22),

                            // Google button
                            _buildSocialButton(
                              icon: Icons.g_mobiledata_rounded,
                              label: 'Google',
                              color: const Color(0xFFDB4437),
                            ),

                            const SizedBox(height: 12),

                            // Facebook button
                            _buildSocialButton(
                              icon: Icons.facebook,
                              label: 'Facebook',
                              color: const Color(0xFF1877F2),
                            ),

                            const SizedBox(height: 12),

                            // Apple button
                            _buildSocialButton(
                              icon: Icons.apple,
                              label: 'Apple',
                              color: Colors.black,
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(
      {required IconData icon, required String label, required Color color}) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF011E71),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                letterSpacing: -0.12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDecorativeCircles() {
    return Stack(
      children: [
        Positioned(
          left: -21,
          top: -117,
          child: Container(
            width: 183,
            height: 183,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 30, color: const Color(0xFF10A2EA)),
            ),
          ),
        ),
        Positioned(
          left: 72.01,
          top: 179.85,
          child: Opacity(
            opacity: 0.30,
            child: Transform.rotate(
              angle: 3.03,
              child: Container(
                width: 153.81,
                height: 153.81,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: const Alignment(0.93, 0.35),
                    end: const Alignment(0.06, 0.40),
                    colors: [const Color(0xAFFDEDCA), const Color(0xFF0A9BE2)],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: -25.70,
          top: 45,
          child: Opacity(
            opacity: 0.30,
            child: Transform.rotate(
              angle: 0.57,
              child: Container(
                width: 89.35,
                height: 89.35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: const Alignment(0.93, 0.35),
                    end: const Alignment(0.06, 0.40),
                    colors: [const Color(0xFFFDEDCA), const Color(0xFF0A9BE2)],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 52.98,
          top: 14.77,
          child: Opacity(
            opacity: 0.30,
            child: Transform.rotate(
              angle: 3.03,
              child: Container(
                width: 94.08,
                height: 94.08,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: const Alignment(0.93, 0.35),
                    end: const Alignment(0.06, 0.40),
                    colors: [const Color(0xAFFDEDCA), const Color(0xFF0A9BE2)],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 265.30,
          top: 79,
          child: Transform.rotate(
            angle: 0.40,
            child: Container(
              width: 167,
              height: 167,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 30, color: const Color(0xFF10A2EA)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
