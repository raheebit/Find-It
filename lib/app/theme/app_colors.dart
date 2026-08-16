import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand
  static const primary = Color(0xFF1E5EFF);
  static const primaryDark = Color(0xFF1748C7);
  static const primaryLight = Color(0xFFEAF0FF);

  // Backgrounds
  static const background = Color(0xFFF8F9FC);
  static const surface = Colors.white;

  // Text
  static const textPrimary = Color(0xFF101828);
  static const textSecondary = Color(0xFF667085);
  static const textTertiary = Color(0xFF98A2B3);

  // Borders
  static const border = Color(0xFFE4E7EC);
  static const borderFocused = primary;

  // Semantic
  static const success = Color(0xFF12B76A);
  static const successLight = Color(0xFFECFDF3);

  static const error = Color(0xFFD92D20);
  static const errorLight = Color(0xFFFEF3F2);

  static const warning = Color(0xFFF79009);
  static const warningLight = Color(0xFFFFFAEB);

  // Report types
  static const lost = Color(0xFFD92D20);
  static const found = Color(0xFF12B76A);

  // Misc
  static const divider = Color(0xFFEAECF0);
  static const disabled = Color(0xFFD0D5DD);
}