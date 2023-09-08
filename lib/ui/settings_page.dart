import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tambola_caller/res/res.dart';
import 'package:tambola_caller/ui/views/animated_background.dart';
import 'package:tambola_caller/utils/prefs.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _prefs = PrefsHelper();

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Text(
        'Settings',
        style: GoogleFonts.poppins(
          fontSize: 48,
          height: 1.2,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildThemeToggleRow(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Text(
            'Dark Theme',
            style: theme.textTheme.titleLarge,
          ),
          const Spacer(),
          CupertinoSwitch(
            value: themeProvider.isDarkMode,
            onChanged: (_) => themeProvider.switchTheme(),
            trackColor: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceToggleRow(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Text(
            'Speak Phrases',
            style: theme.textTheme.titleLarge,
          ),
          const Spacer(),
          CupertinoSwitch(
            value: _prefs.isVoiceoverEnabled,
            onChanged: (value) => _prefs.setIsVoiceoverEnabled(value),
            trackColor: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildThemeToggleRow(theme),
            const Divider(),
            _buildVoiceToggleRow(theme),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedBackground(),
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const RotatedBox(
                      quarterTurns: 2,
                      child: Icon(
                        Icons.arrow_right_alt,
                        size: 48,
                      ),
                    ),
                  ),
                  _buildTitle(),
                  Expanded(child: _buildSettingsSection(theme)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
