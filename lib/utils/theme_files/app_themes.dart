import 'package:diy/utils/theme_files/app_colors.dart';
import 'package:diy/utils/theme_files/app_text_styles.dart';
import 'package:diy/utils/theme_files/theme_colors.dart';
import 'package:flutter/material.dart';

final Map<ThemeMode, ThemeData> appThemes = {
  ThemeMode.light: ThemeData(
    fontFamily: AppTextStyles.fontFamily,
    primaryColor: LightThemeColors.primaryColor,
    accentColor: LightThemeColors.primaryAccent,
    scaffoldBackgroundColor: LightThemeColors.background,
    brightness: Brightness.light,
  ),
  ThemeMode.dark: ThemeData(
    fontFamily: AppTextStyles.fontFamily,
    primaryColor: DarkThemeColors.primaryColor,
    accentColor: DarkThemeColors.primaryAccent,
    scaffoldBackgroundColor: DarkThemeColors.background,
    brightness: Brightness.dark,
  )
};
