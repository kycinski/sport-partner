import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData defaultTheme = ThemeData(
    primarySwatch: Colors.amber,
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.white, fontSize: 18),
      headlineMedium: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
    ),
  );
}
