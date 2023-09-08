import 'package:flutter/material.dart';
import 'package:tambola_caller/res/res.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void switchTheme() {
    themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
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
