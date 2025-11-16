import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_button.dart';
import '../widgets/auth_card_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _pass = TextEditingController();

  // STUB: implement authentication logic later
  Future<void> _onLoginPressed() async {
    // TODO: call AuthController.login(...)
    // For now, simulate success by navigating to profile
    Navigator.pushReplacementNamed(context, '/profile');
  }

  void _onGooglePressed() {
    // TODO: implement google sign-in
    // empty for now
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [theme.scaffoldBackgroundColor,theme.primaryColor.withOpacity(0.2)],stops: [0.75, 1.0], begin: Alignment.topCenter, end: Alignment.bottomRight),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios_new, color:theme.iconTheme.color)),
                const SizedBox(height: 8),
                Text('Welcome back', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600,color: Colors.white)),
                const SizedBox(height: 6),
                Text('Sign in to continue', style: GoogleFonts.poppins(color: Colors.white)),
                const SizedBox(height: 18),
                AuthCardContainer(
                  child: Column(
                    children: [
                      AuthTextField(controller: _email, hint: 'Email', keyboardType: TextInputType.emailAddress),
                      const SizedBox(height: 8),
                      AuthTextField(controller: _pass, hint: 'Password', obscureText: true),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _onLoginPressed,

                          child: Text('Login', style: GoogleFonts.poppins(fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(onPressed: () => Navigator.pushNamed(context, '/forgot'), child: const Text('Forgot password?')),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.white12)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text('Or', style: GoogleFonts.poppins(color: Colors.white70)),
                          ),
                          Expanded(child: Divider(color: Colors.white12)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SocialButton(
                        label: 'Continue with Google',
                        assetUrl: 'assets/logos/google_logo.png',
                        onTap: _onGooglePressed,
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/register'),
                        child: Text("Don't have an account? Register", style: GoogleFonts.poppins(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
