import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static PrefsHelper? _instance;
  late SharedPreferences _prefs;

  PrefsHelper._();

  factory PrefsHelper() {
    _instance ??= PrefsHelper._();
    return _instance!;
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get isVoiceoverEnabled => _prefs.getBool(_enableVoiceover) ?? true;

  void setIsVoiceoverEnabled(bool value) {
    _prefs.setBool(_enableVoiceover, value);
  }

  bool get isDarkModeEnabled => _prefs.getBool(_darkModeEnabled) ?? true;

  void setIsDarkModeEnabled(bool value) {
    _prefs.setBool(_darkModeEnabled, value);
  }

  double get voicePitch => _prefs.getDouble(_voicePitch) ?? 1.0;

  void setVoicePitch(double value) {
    _prefs.setDouble(_voicePitch, value);
  }

  double get voiceRate => _prefs.getDouble(_voiceRate) ?? (kIsWeb ? 0.8 : 0.4);

  void setVoiceRate(double value) {
    _prefs.setDouble(_voiceRate, value);
  }

  final String _enableVoiceover = 'enable_voiceover';
  final String _darkModeEnabled = 'dark_mode_enabled';
  final String _voicePitch = 'voice_pitch';
  final String _voiceRate = 'voice_rate';
}
