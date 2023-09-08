import 'package:flutter/material.dart';
import 'package:tambola_caller/res/res.dart';
import 'package:tambola_caller/utils/prefs.dart';

class ThemeProvider extends ChangeNotifier {
  final _prefs = PrefsHelper();

  bool get isDarkMode => _prefs.isDarkModeEnabled;

  void switchTheme() {
    _prefs.setIsDarkModeEnabled(!isDarkMode);
    notifyListeners();
  }
}

ThemeProvider themeProvider = ThemeProvider();

class MyThemes {
  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(),
    textTheme: textTheme,
    useMaterial3: true,
  );

  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(),
    textTheme: textTheme,
    useMaterial3: true,
  );
}
