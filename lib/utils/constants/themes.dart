import 'package:flutter/material.dart';

class ThemeManager {
  static TextTheme _lightBuildTextTheme(TextTheme base, Color color) {
    return base.copyWith(
      displayLarge: base.displayLarge
          ?.copyWith(color: color, fontFamily: 'IBMPlexSansArabic'),
      displayMedium: base.displayMedium
          ?.copyWith(color: color, fontFamily: 'IBMPlexSansArabic'),
      displaySmall: base.displaySmall
          ?.copyWith(color: color, fontFamily: 'IBMPlexSansArabic'),
      headlineLarge: base.headlineLarge
          ?.copyWith(color: color, fontFamily: 'IBMPlexSansArabic'),
      headlineMedium: base.headlineMedium
          ?.copyWith(color: color, fontFamily: 'IBMPlexSansArabic'),
      headlineSmall: base.headlineSmall
          ?.copyWith(color: color, fontFamily: 'IBMPlexSansArabic'),
      titleLarge: base.titleLarge
          ?.copyWith(color: color, fontFamily: 'IBMPlexSansArabic'),
      titleMedium: base.titleMedium
          ?.copyWith(color: color, fontFamily: 'IBMPlexSansArabic'),
      titleSmall: base.titleSmall
          ?.copyWith(color: color, fontFamily: 'IBMPlexSansArabic'),
      bodyLarge: base.bodyLarge
          ?.copyWith(color: color, fontFamily: 'IBMPlexSansArabic'),
      bodyMedium: base.bodyMedium
          ?.copyWith(color: color, fontFamily: 'IBMPlexSansArabic'),
      bodySmall: base.bodySmall
          ?.copyWith(color: color, fontFamily: 'IBMPlexSansArabic'),
      labelLarge: base.labelLarge
          ?.copyWith(color: color, fontFamily: 'IBMPlexSansArabic'),
      labelMedium: base.labelMedium
          ?.copyWith(color: color, fontFamily: 'IBMPlexSansArabic'),
      labelSmall: base.labelSmall
          ?.copyWith(color: color, fontFamily: 'IBMPlexSansArabic'),
    );
  }

  static ThemeData lightThemeData = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.blue,
    ),
    textTheme: _lightBuildTextTheme(ThemeData.light().textTheme, Colors.black),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
      ),
    ),
  );

  static ThemeData darkThemeData = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.blue,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        unselectedIconTheme: IconThemeData(color: Colors.white)),
    textTheme: _lightBuildTextTheme(ThemeData.light().textTheme, Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.grey[800],
      ),
    ),
  );
}
