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

class PersonalDetails extends StatelessWidget {
  bool isReadOnly;
  PersonalDetails({Key? key, this.isReadOnly = false}) : super(key: key);

  final PersonalDetailsForm = getIt<FormService>().personalDetails;
  @override
  Widget build(BuildContext context) {
    return DiyForm(
      title: 'Personal Details',
      subtitle: 'Your details are safe & secure',
      formGroup: PersonalDetailsForm,
      child: Column(
        children: [
          ReactiveTextField(
            cursorColor: AppColors.primaryColor(context),
            formControlName: 'Gender',
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
              hintText: 'Gender',
              hintStyle:
                  TextStyle(color: AppColors.textColorTextField(context)),

              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor(context)),
                borderRadius: BorderRadius.circular(4),
              ),
              filled: AppColors.textFieldBackground(context) != null,
            ),
            showErrors: (control) => control.invalid && control.hasFocus,
            validationMessages: {
              'required': (error) => 'Required Field',
            },
          ),
          WidgetHelper.verticalSpace,
          ReactiveTextField(
            cursorColor: AppColors.primaryColor(context),
            formControlName: 'MaritalStatus',
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
              hintText: 'Marital Status',
              hintStyle:
                  TextStyle(color: AppColors.textColorTextField(context)),

              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor(context)),
                borderRadius: BorderRadius.circular(4),
              ),
              filled: AppColors.textFieldBackground(context) != null,
            ),
            showErrors: (control) => control.invalid && control.hasFocus,
            validationMessages: {
              'required': (error) => 'Required Field',
            },
          ),
          WidgetHelper.verticalSpace20,
          ReactiveTextField(
            cursorColor: AppColors.primaryColor(context),
            formControlName: 'FatherName',
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
              hintText: 'Father Name',
              hintStyle:
                  TextStyle(color: AppColors.textColorTextField(context)),

              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor(context)),
                borderRadius: BorderRadius.circular(4),
              ),
              filled: AppColors.textFieldBackground(context) != null,
            ),
            showErrors: (control) => control.invalid && control.hasFocus,
            validationMessages: {
              'required': (error) => 'Required Field',
            },
          ),
          WidgetHelper.verticalSpace20,
          ReactiveTextField(
            cursorColor: AppColors.primaryColor(context),
            formControlName: 'MotherName',
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
              hintText: 'Mother Name',
              hintStyle:
                  TextStyle(color: AppColors.textColorTextField(context)),

              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor(context)),
                borderRadius: BorderRadius.circular(4),
              ),
              filled: AppColors.textFieldBackground(context) != null,
            ),
            showErrors: (control) => control.invalid && control.hasFocus,
            validationMessages: {
              'required': (error) => 'Required Field',
            },
          ),
          WidgetHelper.verticalSpace20,
          NextButton(
            text: "Continue",
            onPressed: () async {
              return await getIt<OAuthService>()
                  .sendOtp(
                PersonalDetailsForm.control('phone').value,
              )
                  .then(
                (res) {
                  if (res.status) {
                    AppUtil.showToast(
                      'OTP sent successfully',
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
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
