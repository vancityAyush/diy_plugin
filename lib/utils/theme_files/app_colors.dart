import 'dart:ui';

import 'package:diy/utils/theme_files/theme_colors.dart';
import 'package:diy/utils/theme_files/themed_color.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  static Color background(BuildContext context) => ThemedColor(
        light: LightThemeColors.background,
        dark: DarkThemeColors.background,
      ).getColor(context);

  static Color primaryContent(BuildContext context) => ThemedColor(
        light: LightThemeColors.primaryContent,
        dark: DarkThemeColors.primaryContent,
      ).getColor(context);

  static Color primaryAccent(BuildContext context) => ThemedColor(
        light: LightThemeColors.primaryAccent,
        dark: DarkThemeColors.primaryAccent,
      ).getColor(context);

  static Color primaryColor(BuildContext context) => ThemedColor(
        light: LightThemeColors.primaryColor,
        dark: DarkThemeColors.primaryColor,
      ).getColor(context);

  static Color textFieldBackground(BuildContext context) => ThemedColor(
        light: LightThemeColors.textFieldBackground,
        dark: DarkThemeColors.textFieldBackground,
      ).getColor(context);
  static Color textColorTextField(BuildContext context) => ThemedColor(
        light: LightThemeColors.textColorTextField,
        dark: DarkThemeColors.textColorTextField,
      ).getColor(context);
  static Color footerText(BuildContext context) => ThemedColor(
        light: LightThemeColors.footerText,
        dark: DarkThemeColors.footerText,
      ).getColor(context);
  static Color subHeading(BuildContext context) => ThemedColor(
        light: LightThemeColors.subHeading,
        dark: DarkThemeColors.subHeading,
      ).getColor(context);
  static Color secondaryColor(BuildContext context) => ThemedColor(
        light: LightThemeColors.secondaryColor,
        dark: DarkThemeColors.secondaryColor,
      ).getColor(context);
}
