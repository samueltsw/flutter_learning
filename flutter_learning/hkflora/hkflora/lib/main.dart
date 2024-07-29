import 'package:flutter/material.dart';
import 'package:hkflora/pages/loading.dart';
import 'package:hkflora/theme.dart';

void main() async {
  runApp(MaterialApp(
    theme: const MaterialTheme(TextTheme()).light(),
    darkTheme: const MaterialTheme(TextTheme()).dark(),
    highContrastDarkTheme: const MaterialTheme(TextTheme()).darkHighContrast(),
    highContrastTheme: const MaterialTheme(TextTheme()).lightHighContrast(),
    themeMode: ThemeMode.light,
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const Loading(), // '/' = base route
    },
  ));
}
