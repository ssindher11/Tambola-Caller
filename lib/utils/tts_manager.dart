import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:tambola_caller/utils/prefs.dart';

class TtsManager {
  static TtsManager? _instance;
  late FlutterTts _flutterTts;
  final _prefs = PrefsHelper();

  FlutterTts get tts => _flutterTts;

  TtsManager._();

  factory TtsManager() {
    _instance ??= TtsManager._();
    return _instance!;
  }

  bool get _isVoiceoverEnabled => _prefs.isVoiceoverEnabled;

  Future<void> init() async {
    _flutterTts = FlutterTts();
    if (Platform.isIOS || Platform.isMacOS) {
      await _flutterTts.setSharedInstance(true);
      await _flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.ambient,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.allowAirPlay,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers,
        ],
        IosTextToSpeechAudioMode.voicePrompt,
      );
    }
    await _flutterTts.awaitSpeakCompletion(true);
    await _flutterTts.awaitSynthCompletion(true);
    await _flutterTts.setLanguage('en-IN');
    await _flutterTts.setVoice({'name': 'en-IN-language', 'locale': 'en-IN'});
    await _flutterTts.setSpeechRate(0.4);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> speak(String text, {VoidCallback? onPlaying}) async {
    if (_isVoiceoverEnabled) {
      var result = await _flutterTts.speak(text);
      if (result == 1) {
        onPlaying?.call();
      }
    }
  }

  Future<void> stop({VoidCallback? onStopped}) async {
    var result = await _flutterTts.stop();
    if (result == 1) {
      onStopped?.call();
    }
  }
}
