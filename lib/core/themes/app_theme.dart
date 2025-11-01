import 'package:flutter/material.dart';

class AppTheme {
  // EcoChip brand colors
  static const Color primaryGreen = Color(0xFF4C8B7F);
  static const Color secondaryGreen = Color(0xFF2E5E54);
  static const Color secondaryBlue = Color(
    0xFF2196F3,
  ); // For backward compatibility
  static const Color accentOrange = Color(0xFFFF9800);
  static const Color textDark = Color(0xFF3E3E3E);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryGreen,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: primaryGreen,
      secondary: secondaryGreen,
      surface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: primaryGreen),
      titleTextStyle: TextStyle(
        color: textDark,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
