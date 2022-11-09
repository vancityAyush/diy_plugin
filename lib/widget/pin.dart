import 'package:diy/utils/theme_files/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CodePin extends StatelessWidget {
  final TextEditingController pinController;
  const CodePin({Key? key, required this.pinController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
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
      controller: pinController,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) => print(pin),
    );
  }
}
