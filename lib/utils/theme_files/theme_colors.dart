import 'dart:ui';

import 'package:flutter/material.dart';

abstract class LightThemeColors {
  static Color get background => const Color(0xFFf8f8f8);
  static Color get primaryContent => const Color(0xFF000000);
  static Color get primaryAccent => const Color(0xFF354157);
  static Color get primaryColor => const Color(0xFFFA4181);
  static Color get textFieldBackground => Color(0xFFEBE9EB);
  static Color get textColorTextField => Color(0xFF7F868C);
  static Color get footerText => Color(0xFF3B444B);
  static Color get subHeading => Color(0xFF999999);
}

abstract class DarkThemeColors {
  static Color get background => const Color(0xFF111619);
  static Color get primaryContent => const Color(0xFFE1E1E1);
  static Color get primaryAccent => const Color(0xFF354157);
  static Color get primaryColor => const Color(0xFFFA4181);
  static Color get textFieldBackground => Color(0xFF2C3339);
  static Color get textColorTextField => Color(0xFF7F868C);
  static Color get footerText => Color(0xFF3B444B);
  static Color get subHeading => Color(0xFF999999);
}
