import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_button.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _obscure = true;

  Future<void> _onLoginPressed() async {
    final notifier = ref.read(authControllerProvider.notifier);
    await notifier.login(_email.text.trim(), _pass.text.trim());

    final authState = ref.read(authControllerProvider);
    if (authState.error != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(authState.error!)));
    } else if (authState.user != null) {
      Navigator.pushReplacementNamed(context, '/movies_home');
    }
  }

  Future<void> _onGooglePressed() async {
    final notifier = ref.read(authControllerProvider.notifier);
    await notifier.loginWithGoogle();

    final authState = ref.read(authControllerProvider);
    if (authState.error != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(authState.error!)));
    } else if (authState.user != null) {
      Navigator.pushReplacementNamed(context, '/movies_home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final auth = ref.watch(authControllerProvider);

    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0A0F),
              Color(0xFF1A0A2E),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                // Logo
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          // replaced withOpacity(0.3) by equivalent ARGB
                          color: Color(0x4D8B5CF6),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Title
                Text(
                  "Welcome Back",
                  style: theme.textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "Sign in to continue",
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Email
                AuthTextField(
                  controller: _email,
                  hint: "Email address",
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 16),

                // Password
                AuthTextField(
                  controller: _pass,
                  hint: "Password",
                  obscureText: _obscure,
                  icon: Icons.lock_outline,
                  suffix: IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: theme.textTheme.bodySmall!.color,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),

                const SizedBox(height: 16),

                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(context, "/forgot"),
                    child: Text(
                      "Forgot?",
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Login Button
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                    ),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x4D8B5CF6),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: auth.loading ? null : _onLoginPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: auth.loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Sign In"),
                  ),
                ),
                const SizedBox(height: 32),

                // Divider
                Row(
                  children: [
                    const Expanded(child: Divider(color: Color(0xFF6B6B80))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "OR",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    const Expanded(child: Divider(color: Color(0xFF6B6B80))),
                  ],
                ),
                const SizedBox(height: 32),

                // Social login
                SocialButton(
                  label: "Continue with Google",
                  icon: Icons.g_mobiledata,
                  onTap: auth.loading ? null : () => _onGooglePressed(),
                ),
                const SizedBox(height: 24),

                // Sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: theme.textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, "/register"),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
