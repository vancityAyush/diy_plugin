import 'dart:ui';

abstract class LightThemeColors {
  static Color get background => const Color(0xFFf8f8f8);
  static Color get primaryContent => const Color(0xFF000000);
  static Color get primaryAccent => const Color(0xFF354157);
  static Color get primaryColor => const Color(0xFFE95885);
  static Color get textFieldBackground => Color.fromARGB(255, 231, 231, 231);
}

abstract class DarkThemeColors {
  static Color get background => const Color(0xFF121619);
  static Color get primaryContent => const Color(0xFFE1E1E1);
  static Color get primaryAccent => const Color(0xFF354157);
  static Color get primaryColor => const Color(0xFFE95885);
  static Color get textFieldBackground => Color(0xff2D3338);
}
