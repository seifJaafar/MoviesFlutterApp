import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/auth_text_field.dart' as _dummy; // to avoid unused import warning
import '../widgets/auth_card_container.dart' as _dummy; // to avoid unused import warning

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  // navigation helpers (UI-only)
  void _goToLogin(BuildContext ctx) => Navigator.pushReplacementNamed(ctx, '/login');
  void _goToRegister(BuildContext ctx) => Navigator.pushReplacementNamed(ctx, '/register');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF140B23), Color(0xFF0B0812)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  children: [
                    Text('Welcome', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600)),
                    const Spacer(),
                    TextButton(
                      onPressed: () => _goToLogin(context),
                      child: Text('Skip', style: GoogleFonts.poppins(color: Colors.white70)),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: PageView(
                  children: [
                    _buildSlide(title: 'Discover Movies', subtitle: 'Explore latest and trending movies', imageUrl: 'https://picsum.photos/seed/1/600/400'),
                    _buildSlide(title: 'Create Watchlists', subtitle: 'Save and share watchlists with friends', imageUrl: 'https://picsum.photos/seed/2/600/400'),
                    _buildSlide(title: 'Get Notifications', subtitle: 'Never miss new releases or reviews', imageUrl: 'https://picsum.photos/seed/3/600/400'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _goToRegister(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7C4DFF),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('Get Started', style: GoogleFonts.poppins(fontSize: 16)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlide({required String title, required String subtitle, required String imageUrl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 12)],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(title, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(subtitle, style: GoogleFonts.poppins(color: Colors.white70), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
