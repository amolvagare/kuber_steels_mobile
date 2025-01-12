import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF2C3A3A); // Dark teal for primary branding
  static const Color secondaryColor = Color(0xFF243232); // Darker teal for secondary elements
  static const Color cardColor = Color(0xFFEFEFEF); // Light grey for card backgrounds
  static const Color accentColor = Color(0xFF34495E); // Slate blue for accents
  static const Color backgroundColor = Colors.white; // Light background for screens
  static const Color textColor = Colors.black; // Black text for readability on light background
  static const Color subtleText = Colors.grey; // Grey for secondary text
  static const Color fieldBg = Color(0xFFF5F5F5); // Very light grey for input fields
}

ThemeData getAppTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    primaryColor: AppColors.primaryColor,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.accentColor,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textColor, fontSize: 16),
      bodyMedium: TextStyle(color: AppColors.subtleText),
      labelLarge: TextStyle(color: AppColors.primaryColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.fieldBg,
      labelStyle: const TextStyle(color: AppColors.subtleText),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white, // Text color for button
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    ),
  );
}
