import 'package:flutter/material.dart';
import 'package:tambola_caller/res/theme_provider.dart';
import 'package:tambola_caller/ui/landing_page.dart';
import 'package:tambola_caller/utils/prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefsHelper = PrefsHelper();
  await prefsHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _prefs = PrefsHelper();

  @override
  void initState() {
    super.initState();
    themeProvider.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: MyThemes.darkTheme,
      theme: MyThemes.lightTheme,
      themeMode: _prefs.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const LandingPage(),
    );
  }
}
