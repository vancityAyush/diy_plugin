import 'package:diy/diy.dart';
import 'package:diy/network/api_repository.dart';
import 'package:diy/utils/theme_files/app_colors.dart';
import 'package:diy/widget/diy_form.dart';
import 'package:diy/widget/next_button.dart';
import 'package:diy/widget/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../form_service.dart';

class EnterPan extends StatelessWidget {
  bool isReadOnly;
  EnterPan({Key? key, this.isReadOnly = false}) : super(key: key);
  final panForm = getIt<FormService>().panForm;

  @override
  Widget build(BuildContext context) {
    if (!isReadOnly) {
      panForm.reset();
    }
    return DiyForm(
      title: "Enter PAN & Date of Birth",
      subtitle: "A PAN card is compulsory for investing in India",
      formGroup: panForm,
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
          NextButton(
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
                    getIt<FormService>().validatePanForm.value = value;
                    final form = getIt<FormService>().validatePanForm;
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/app/validate-kra/", (route) => false,
                        arguments: {"response": value});
                    return true;
                  } else {
                    //TODO show error
                    return false;
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
