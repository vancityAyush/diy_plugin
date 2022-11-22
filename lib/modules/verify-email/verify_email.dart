import 'package:diy/diy.dart';
import 'package:diy/network/oauth_service.dart';
import 'package:diy/utils/util.dart';
import 'package:diy/widget/diy_form.dart';
import 'package:diy/widget/next_button.dart';
import 'package:diy/widget/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_pin_code_fields/reactive_pin_code_fields.dart';

import '../../../utils/theme_files/app_colors.dart';

class VerifyEmailPage extends StatelessWidget {
  VerifyEmailPage({
    Key? key,
  }) : super(key: key);

  final otpForm = FormGroup(
    {
      'otp': FormControl<String>(
        validators: [Validators.required, Validators.minLength(4)],
      ),
      'TnC': FormControl<bool>(validators: [Validators.requiredTrue]),
    },
  );

  @override
  Widget build(BuildContext context) {
    return DiyForm(
      title: 'Verify Your Email Address',
      subtitle: "Please enter the OTP sent to your email",
      formGroup: otpForm,
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: getIt<OAuthService>().response["Email"] + "  ",
                  style: TextStyle(
                    color: AppColors.primaryContent(context),
                    fontSize: 16.sp,
                  ),
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.edit,
                      color: AppColors.primaryContent(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          WidgetHelper.verticalSpace20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ReactivePinCodeTextField<String>(
              formControlName: 'otp',
              length: 4,
              keyboardType: TextInputType.number,
              validationMessages: {
                'required': (error) => 'The OTP must not be empty',
                'minLength': (error) =>
                    'The OTP must have at least 4 characters',
              },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                activeColor: AppColors.primaryColor(context),
              ),
              showErrors: (control) => control.invalid && control.dirty,
            ),
          ),
          WidgetHelper.verticalSpace20,
          GestureDetector(
            onTap: () async {
              await getIt<OAuthService>()
                  .sendEmailOtp(email: getIt<OAuthService>().response["Email"])
                  .then(
                (value) {
                  if (value.status) {
                    AppUtil.showToast("OTP sent successfully");
                  } else {
                    AppUtil.showToast("Something went wrong");
                  }
                },
              );
            },
            child: Text(
              'Resend OTP',
              style: TextStyle(
                color: AppColors.primaryColor(context),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          WidgetHelper.verticalSpace20,
          NextButton(
            text: "Verify",
            onPressed: () async {
              final res = await getIt<OAuthService>().validateEmail(
                otp: otpForm.control('otp').value,
              );
              if (res.status) {
                AppUtil.showToast("OTP verified successfully");
                await getIt<OAuthService>().updateUiStatus().then(
                      (route) => Navigator.pushNamedAndRemoveUntil(
                        context,
                        route,
                        (route) => false,
                      ),
                    );
                return true;
              } else {
                AppUtil.showToast("Something went wrong");
              }
              return false;
            },
          ),
          WidgetHelper.verticalSpace20,
          ReactiveCheckboxListTile(
            formControlName: 'TnC',
            title: Text(
              "I understand and authorize JM Financial Services to contact me via email for all future communication",
              style: TextStyle(
                color: AppColors.primaryContent(context),
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
