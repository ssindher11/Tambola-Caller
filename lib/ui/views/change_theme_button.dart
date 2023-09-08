import 'package:flutter/material.dart';
import 'package:tambola_caller/res/theme_provider.dart';

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*return Switch.adaptive(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        themeProvider.toggleTheme(value);
      },
    );*/
    return IconButton(
      onPressed: themeProvider.switchTheme,
      icon: Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
    );
  }
}
