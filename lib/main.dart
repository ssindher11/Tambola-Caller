import 'package:flutter/material.dart';
import 'package:tambola_caller/res/theme_provider.dart';
import 'package:tambola_caller/ui/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false,
      home: const LandingPage(),
    );
  }
}
