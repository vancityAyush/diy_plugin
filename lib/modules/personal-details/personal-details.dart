import 'package:diy/diy.dart';
import 'package:diy/modules/form_service.dart';
import 'package:diy/network/api_repository.dart';
import 'package:diy/utils/libs.dart';
import 'package:diy/widget/diy_form.dart';
import 'package:diy/widget/next_button.dart';
import 'package:diy/widget/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../utils/theme_files/app_colors.dart';
import '../../network/oauth_service.dart';

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
          Container(
            height: 55.sp,
            decoration: BoxDecoration(
                color: AppColors.textFieldBackground(context),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ReactiveDropdownField<int>(
                  dropdownColor: AppColors.textFieldBackground(context),
                  formControlName: 'Gender',
                  items: const [
                    DropdownMenuItem(
                      value: 1,
                      child: Text("Male"),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text("Female"),
                    ),
                  ],
                  icon: Icon(Icons.arrow_drop_down),
                  style: TextStyle(
                    color: AppColors.textColorTextField(context),
                  ),
                  hint: Text('Select Gender',
                      style: TextStyle(
                        color: AppColors.textColorTextField(context),
                      )),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  showErrors: (control) => control.invalid && control.dirty,
                  validationMessages: {
                    'required': (error) => 'Please Select Gender',
                  },
                  iconSize: 30,
                  iconEnabledColor: AppColors.primaryColor(context),
                  iconDisabledColor: AppColors.primaryContent(context),
                ),
              ),
            ),
          ),
          WidgetHelper.verticalSpace20,
          Container(
            height: 55.sp,
            decoration: BoxDecoration(
                color: AppColors.textFieldBackground(context),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ReactiveDropdownField<int>(
                  dropdownColor: AppColors.textFieldBackground(context),
                  formControlName: 'MaritalStatus',
                  items: const [
                    DropdownMenuItem(
                      value: 1,
                      child: Text("Single"),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text("Married"),
                    ),
                  ],
                  icon: Icon(Icons.arrow_drop_down),
                  style: TextStyle(
                    color: AppColors.textColorTextField(context),
                  ),
                  hint: Text('Maritial Status',
                      style: TextStyle(
                        color: AppColors.textColorTextField(context),
                      )),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    // filled: AppColors.textFieldBackground(context) != null,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  showErrors: (control) => control.invalid && control.dirty,
                  validationMessages: {
                    'required': (error) => 'Please Select Marital Status',
                  },
                  iconSize: 30,
                  iconEnabledColor: AppColors.primaryColor(context),
                  iconDisabledColor: AppColors.primaryContent(context),
                ),
              ),
            ),
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
            keyboardType: TextInputType.name,
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
              await getIt<ApiRepository>()
                  .savePersonalDetails(PersonalDetailsForm.value);
              await getIt<OAuthService>().updateUiStatus().then(
                    (route) => Navigator.pushNamedAndRemoveUntil(
                      context,
                      route,
                      (route) => false,
                    ),
                  );
              return true;
            },
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
