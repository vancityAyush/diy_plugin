import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WidgetHelper {
  static const verticalSpace5 = SizedBox(height: 5);
  static const verticalSpace = SizedBox(height: 10);
  static const verticalSpace20 = SizedBox(height: 20);
  static const horizontalSpace = SizedBox(width: 10);
  static const horizontalSpace20 = SizedBox(width: 20);

  static Widget blank() => Container();

  static String formatDate(DateTime? date) {
    return date == null ? '' : DateFormat("dd-MM-yyyy").format(date);
  }
}
