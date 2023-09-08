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

  bool get isVoiceoverEnabled => _prefs.getBool(_enableVoiceover) ?? false;

  void setIsVoiceoverEnabled(bool value) {
    _prefs.setBool(_enableVoiceover, value);
  }

  bool get isDarkModeEnabled => _prefs.getBool(_darkModeEnabled) ?? false;

  void setIsDarkModeEnabled(bool value) {
    _prefs.setBool(_darkModeEnabled, value);
  }

  final String _enableVoiceover = 'enable_voiceover';
  final String _darkModeEnabled = 'dark_mode_enabled';
}
