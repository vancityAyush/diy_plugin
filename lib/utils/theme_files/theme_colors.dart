import 'dart:ui';

import 'package:flutter/material.dart';

abstract class LightThemeColors {
  static Color get background => const Color(0xFFffffff);
  static Color get primaryColor => const Color(0xFFE95885);
  static Color get textFieldBackground => Color(0xFFE8EAEE);
  static Color get textColorTextField => Color(0xFF6D6D6D);
  static Color get subHeading => Color(0xFF646979);
  static Color get secondaryColor => const Color(0xFFD7D7D7);
  //unused
  static Color get footerText => Color(0xFF3B444B);
  static Color get primaryContent => const Color(0xFF000000);
  static Color get primaryAccent => const Color(0xFF354157);
}

abstract class DarkThemeColors {
  static Color get background => const Color(0xFF1C2227);
  static Color get primaryColor => const Color(0xFFE95885);
  static Color get textFieldBackground => Color(0xFF2D3338);
  static Color get textColorTextField => Color(0xFF80868B);
  static Color get subHeading => Color(0xFF646979);
  static Color get secondaryColor => const Color(0xFF23272E);
  //unused
  static Color get footerText => Color(0xFF3B444B);
  static Color get primaryContent => const Color(0xFFE1E1E1);
  static Color get primaryAccent => const Color(0xFF354157);
}
