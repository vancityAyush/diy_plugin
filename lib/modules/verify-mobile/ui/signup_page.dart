import 'package:diy/diy.dart';
import 'package:diy/modules/form_service.dart';
import 'package:diy/utils/util.dart';
import 'package:diy/widget/diy_form.dart';
import 'package:diy/widget/next_button.dart';
import 'package:diy/widget/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../network/oauth_service.dart';
import '../../../utils/theme_files/app_colors.dart';
import 'otp_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final signUpForm = getIt<FormService>().signUpForm;
  @override
  Widget build(BuildContext context) {
    return DiyForm(
      title: 'Sign Up Now',
      formGroup: signUpForm,
      child: Column(
        children: [
          ReactiveTextField(
            cursorColor: AppColors.primaryColor(context),
            formControlName: 'phone',
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              fillColor: AppColors.textFieldBackground(context),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.textFieldBackground(context),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primaryColor(context),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              // labelText: 'Phone Number',
              // labelStyle: TextStyle(color: AppColors.primaryContent(context)),
              hintText: 'Your 10 digit phone number',
              hintStyle:
                  TextStyle(color: AppColors.textColorTextField(context)),
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    '+91',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColorTextField(context)),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '|',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryContent(context),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor(context)),
                borderRadius: BorderRadius.circular(4),
              ),
              filled: AppColors.textFieldBackground(context) != null,
            ),
            maxLength: 10,
            showErrors: (control) => control.invalid && control.hasFocus,
            validationMessages: {
              'required': (error) => 'The Phone Number must not be empty',
              'minLength': (error) =>
                  'The Phone Number must have at least 10 characters',
            },
          ),
          WidgetHelper.verticalSpace,
          Text(
            "You will receive an OTP on your number",
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 6),
        ],
      ),
      terms: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            NextButton(
              text: "Continue",
              onPressed: () async {
                return await getIt<OAuthService>()
                    .sendOtp(
                  signUpForm.control('phone').value,
                )
                    .then(
                  (res) {
                    if (res.status) {
                      AppUtil.showToast(
                        'OTP sent successfully',
                      );
                      Navigator.of(context).push(
                        AppUtil.pageBuilder(
                          OtpPage(
                              phoneNumber: signUpForm.control('phone').value),
                        ),
                      );
                      return true;
                    } else {
                      AppUtil.showErrorToast(res.arguments);
                    }
                    return false;
                  },
                );
              },
            ),
            WidgetHelper.verticalSpace,
            Row(
              children: [
                ReactiveCheckbox(
                  formControlName: 'TnC',
                  activeColor: AppColors.primaryColor(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text:
                          'I understand and authorize JM Financial Services to contact me via SMS, Calls, and WhatsApp for all future communication ',
                      style: Theme.of(context).textTheme.caption,
                      children: [
                        TextSpan(
                          text: 'Terms and Conditions',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: AppColors.primaryColor(context),
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
