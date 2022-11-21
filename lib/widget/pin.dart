import 'package:diy/utils/theme_files/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class CodePin extends StatelessWidget {
  final Function onChanged;
  const CodePin({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50.sp,
      height: 50.sp,
      textStyle: TextStyle(
          fontSize: 20.sp,
          color: AppColors.primaryColor(context),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: AppColors.background(context),
        border: Border.all(color: AppColors.primaryContent(context)),
        borderRadius: BorderRadius.circular(5),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primaryColor(context)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Pinput(
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onChanged: (value) {
        onChanged(value);
      },
    );
  }
}
