import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_card_container.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _email = TextEditingController();
  bool _sent = false;

  // STUB: implement send password reset
  Future<void> _onSendResetPressed() async {
    // TODO: call AuthController.sendPasswordReset(...)
    setState(() => _sent = true);
    // keep on this page or navigate to login
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
                Text('Reset password', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600,color: Colors.white)),
                const SizedBox(height: 6),
                Text('Enter your email to receive a reset link', style: GoogleFonts.poppins(color: Colors.white)),
                const SizedBox(height: 18),
                AuthCardContainer(
                  child: Column(
                    children: [
                      AuthTextField(controller: _email, hint: 'Email', keyboardType: TextInputType.emailAddress),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _onSendResetPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7C4DFF),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(_sent ? 'Link sent' : 'Send reset link', style: GoogleFonts.poppins(fontSize: 16)),
                        ),
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
