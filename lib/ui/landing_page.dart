import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tambola_caller/ui/game_page.dart';
import 'package:tambola_caller/ui/settings_page.dart';
import 'package:tambola_caller/ui/views/animated_background.dart';
import 'package:tambola_caller/ui/views/animated_text_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedBackground(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 48,
                    horizontal: 24,
                  ),
                  child: Text(
                    'Tambola Number Caller',
                    style: GoogleFonts.poppins(
                      fontSize: 60,
                      height: 1.2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                AnimatedTextButton(
                  text: 'Start',
                  margin: const EdgeInsets.all(24),
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const GamePage()),
                    );
                  },
                ),
                AnimatedTextButton(
                  text: 'Settings',
                  margin: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: 48,
                  ),
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SettingsPage()),
                    );
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
