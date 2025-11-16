import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // STUB: replace with real logout logic later
  void _onLogoutPressed(BuildContext ctx) {
    // TODO: call AuthController.logout()
    Navigator.pushReplacementNamed(ctx, '/login');
  }

  @override
  Widget build(BuildContext context) {
    // UI-only: show placeholder user info
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 40, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12')),
            const SizedBox(height: 12),
            Text('Full Name', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text('email@example.com', style: GoogleFonts.poppins(color: Colors.white70)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => _onLogoutPressed(context), child: const Text('Logout')),
          ],
        ),
      ),
    );
  }
}
