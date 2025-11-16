import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_card_container.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();

  // STUB: implement registration logic later
  Future<void> _onRegisterPressed() async {
    // TODO: call AuthController.register(...)
    // For now simulate success
    Navigator.pushReplacementNamed(context, '/profile');
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
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white70)),
                const SizedBox(height: 8),
                Text('Create account', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600,color: Colors.white)),
                const SizedBox(height: 6),
                Text('Let\'s set up your account', style: GoogleFonts.poppins(color: Colors.white)),
                const SizedBox(height: 18),
                AuthCardContainer(
                  child: Column(
                    children: [
                      AuthTextField(controller: _name, hint: 'Full name'),
                      const SizedBox(height: 8),
                      AuthTextField(controller: _email, hint: 'Email', keyboardType: TextInputType.emailAddress),
                      const SizedBox(height: 8),
                      AuthTextField(controller: _pass, hint: 'Password', obscureText: true),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _onRegisterPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7C4DFF),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text('Create account', style: GoogleFonts.poppins(fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(onPressed: () => Navigator.pushNamed(context, '/login'), child: const Text('Already have an account? Login')),
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
