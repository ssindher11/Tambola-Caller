import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tambola_caller/res/res.dart';
import 'package:tambola_caller/ui/views/animated_background.dart';
import 'package:tambola_caller/ui/views/audio_waveform.dart';
import 'package:tambola_caller/utils/prefs.dart';
import 'package:tambola_caller/utils/tts_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _prefs = PrefsHelper();
  final _ttsManager = TtsManager();

  bool _voiceoverEnabled = false;
  double _pitch = 1.0;
  double _rate = 0.4;
  bool _isSamplePlaying = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _voiceoverEnabled = _prefs.isVoiceoverEnabled;
      _pitch = _prefs.voicePitch;
      _rate = _prefs.voiceRate;
    });
  }

  @override
  void dispose() {
    _ttsManager.stop();
    super.dispose();
  }

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
    return Row(
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
    );
  }

  Widget _buildVoiceToggleSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Speak Phrases',
              style: theme.textTheme.titleLarge,
            ),
            const Spacer(),
            CupertinoSwitch(
              value: _voiceoverEnabled,
              onChanged: (value) {
                _prefs.setIsVoiceoverEnabled(value);
                setState(() {
                  _voiceoverEnabled = value;
                });
              },
              trackColor: Colors.black,
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Divider(),
        ),
        Text(
          'Voice pitch: ${_pitch.toStringAsFixed(1)}',
          style: theme.textTheme.titleMedium,
        ),
        SizedBox(
          width: double.infinity,
          child: CupertinoSlider(
            value: _pitch,
            onChanged: (value) {
              _ttsManager.setVoicePitch(value);
              setState(() {
                _pitch = value;
              });
            },
            min: 0.5,
            max: 2.0,
            divisions: 15,
            activeColor: const Color(0xFF30D158),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Speech rate: ${_rate.toStringAsFixed(1)}',
          style: theme.textTheme.titleMedium,
        ),
        SizedBox(
          width: double.infinity,
          child: CupertinoSlider(
            value: _rate,
            onChanged: (value) {
              _ttsManager.setVoiceRate(value);
              setState(() {
                _rate = value;
              });
            },
            min: 0.0,
            max: 1.0,
            divisions: 10,
            activeColor: const Color(0xFF30D158),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Sample',
          style: theme.textTheme.titleMedium,
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                if (!_isSamplePlaying) {
                  _ttsManager.speak('This is a sample', onPlaying: () {
                    setState(() {
                      _isSamplePlaying = false;
                    });
                  });
                  setState(() {
                    _isSamplePlaying = true;
                  });
                }
              },
              style: ButtonStyle(
                padding: const MaterialStatePropertyAll(
                  EdgeInsets.fromLTRB(12, 4, 16, 4),
                ),
                backgroundColor: MaterialStatePropertyAll(
                  themeProvider.isDarkMode
                      ? const Color(0xFF0A84FF)
                      : const Color(0xFF007AFF),
                ),
                foregroundColor: const MaterialStatePropertyAll(Colors.white),
              ),
              child: const Row(
                children: [Icon(Icons.play_arrow_rounded), Text(' Play')],
              ),
            ),
            const SizedBox(width: 40),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              opacity: _isSamplePlaying ? 1 : 0,
              child: AudioWaveform(isPlaying: _isSamplePlaying),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsCard(ThemeData theme, Widget child) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: child,
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
                  const SizedBox(height: 40),
                  _buildSettingsCard(theme, _buildThemeToggleRow(theme)),
                  _buildSettingsCard(theme, _buildVoiceToggleSection(theme)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
