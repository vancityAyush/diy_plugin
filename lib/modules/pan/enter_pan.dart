import 'package:diy/diy.dart';
import 'package:diy/network/api_repository.dart';
import 'package:diy/utils/libs.dart';
import 'package:diy/utils/theme_files/app_colors.dart';
import 'package:diy/widget/diy_form.dart';
import 'package:diy/widget/next_button.dart';
import 'package:diy/widget/widget_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../form_service.dart';

class EnterPan extends StatelessWidget {
  bool isReadOnly;
  EnterPan({Key? key, this.isReadOnly = false}) : super(key: key);
  final panForm = getIt<FormService>().panForm;
  final kraForm = getIt<FormService>().validatePanForm;

  @override
  Widget build(BuildContext context) {
    if (!isReadOnly) {
      panForm.reset();
    }
    return DiyForm(
      title: "Enter PAN & DOB",
      subtitle: "A PAN card is compulsory for investing in India",
      formGroup: panForm,
      child: SizedBox(
        height: WidgetsBinding.instance.window.physicalSize.height / 5,
        child: Column(
          children: [
            ReactiveTextField(
              readOnly: isReadOnly,
              formControlName: "pan",
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                filled: AppColors.textFieldBackground(context) != null,
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
                // labelText: "PAN",
                hintText: "Enter your PAN",
                border: OutlineInputBorder(),
              ),
              validationMessages: {
                ValidationMessage.required: (error) => "PAN is required",
                ValidationMessage.minLength: (error) =>
                    "PAN should be 10 characters long",
                ValidationMessage.pattern: (error) => "PAN is invalid",
              },
              showErrors: (control) =>
                  control.invalid && control.touched || control.dirty,
            ),
            WidgetHelper.verticalSpace20,
            ReactiveDatePicker(
              formControlName: 'dob',
              firstDate: DateTime(1950),
              lastDate: DateTime.now(),
              builder: (BuildContext context,
                  ReactiveDatePickerDelegate<dynamic> picker, Widget? child) {
                return ReactiveTextField(
                  formControlName: "dob",
                  readOnly: isReadOnly,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    filled: AppColors.textFieldBackground(context) != null,
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
                    //labelText: "Date of Birth",
                    hintText: "Enter your Date of Birth",
                    suffixIconColor: AppColors.primaryColor(context),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.calendar_month,
                        color: AppColors.primaryColor(context),
                      ),
                      onPressed: () {
                        picker.showPicker();
                      },
                    ),
                  ),
                );
              },
            ),
            WidgetHelper.verticalSpace20,
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: NextButton(
                  text: "Verify",
                  onPressed: () async {
                    return await getIt<ApiRepository>()
                        .validatePan(
                      pan: panForm.control("pan").value,
                      dob: panForm.control("dob").value,
                    )
                        .then(
                      (value) async {
                        if (value != null) {
                          //   getIt<FormService>().validatePanForm.value = value;
                          //   final form = getIt<FormService>().validatePanForm;
                          //   Navigator.pushNamedAndRemoveUntil(
                          //       context, "/app/validate-kra/", (route) => false,
                          //       arguments: {"response": value});
                          showCustomDialog(context);

                          return true;
                        } else {
                          //TODO show error
                          return false;
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (dialogContext) {
        return Center(
          child: Container(
            height: WidgetsBinding.instance.window.physicalSize.height / 5,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.background(context),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.primaryColor(context),
                  child: Icon(
                    Icons.person,
                    color: AppColors.primaryAccent(context),
                    size: 100,
                  ),
                ),
                WidgetHelper.verticalSpace20,
                Center(
                  child: Text(
                    "Hello, ${kraForm.control('FirstName').value} ${kraForm.control('MiddleName').value} ${kraForm.control('LastName').value}",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                WidgetHelper.verticalSpace20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: NextButton(
                    text: "Confirm name on PAN",
                    validateForm: false,
                    onPressed: () async {
                      try {
                        await getIt<ApiRepository>().validateKra(kraForm.value);

                        return true;
                      } catch (e) {
                        return false;
                      } finally {
                        Navigator.pop(dialogContext);
                        await getIt<OAuthService>().updateUiStatus().then(
                              (newRoute) => Navigator.pushNamedAndRemoveUntil(
                                  context, newRoute, (route) => false),
                            );
                      }
                    },
                  ),
                ),
                WidgetHelper.verticalSpace20,
                RichText(
                  text: TextSpan(
                    text: "Incorrect Pan ? ",
                    style: TextStyle(
                      color: AppColors.primaryContent(context),
                      fontSize: 16.sp,
                    ),
                    children: [
                      TextSpan(
                        text: "Re-enter PAN",
                        style: TextStyle(
                          color: AppColors.primaryColor(context),
                          fontSize: 16.sp,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pop();
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
