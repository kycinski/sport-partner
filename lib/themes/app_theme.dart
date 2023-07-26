import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData defaultTheme = ThemeData(
    primarySwatch: Colors.amber,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white, fontSize: 18),
      bodySmall: TextStyle(fontSize: 14),
      headlineMedium: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
    ),
  );
}
