import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData defaultTheme = ThemeData(
    primarySwatch: Colors.amber,
    textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white, fontSize: 18),
        bodySmall: TextStyle(fontSize: 14),
        headlineMedium: TextStyle(
          shadows: <Shadow>[
            Shadow(
              offset: Offset(3, 3),
              blurRadius: 5.0,
              color: Colors.black,
            ),
          ],
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(fontSize: 18)),
  );

  static Widget? defaultAppBarTheme = Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Colors.amber.shade500, Colors.amber.shade200],
      ),
    ),
  );
}
