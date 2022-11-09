import 'dart:ui';

import 'package:diy/utils/theme_files/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static const fontFamily = 'BeVietnamPro'; //TODO: Add font name

  //          //
  // HEADLINE //
  //          //
  static TextStyle headline1(BuildContext context, {required Color color}) {
    return TextStyle(
      color: AppColors.primaryContent(context),
      fontSize: 34,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
    );
  }

  //          //
  //   Body   //
  //          //
  static TextStyle body1(BuildContext context, {required Color color}) {
    return TextStyle(
      color: color ?? AppColors.primaryContent(context),
      fontSize: 18,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
    );
  }

  //          //
  //   Body   //
  //          //
  static TextStyle subtitle1(BuildContext context, {required Color color}) {
    return TextStyle(
      color: color ?? AppColors.primaryContent(context),
      fontSize: 16,
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
    );
  }
}
