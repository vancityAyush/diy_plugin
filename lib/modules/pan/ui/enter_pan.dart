import 'package:diy/diy.dart';
import 'package:diy/network/api_repository.dart';
import 'package:diy/utils/theme_files/app_colors.dart';
import 'package:diy/widget/diy_form.dart';
import 'package:diy/widget/next_button.dart';
import 'package:diy/widget/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EnterPan extends StatelessWidget {
  EnterPan({Key? key}) : super(key: key);

  final panForm = FormGroup(
    {
      'pan': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(10),
          Validators.pattern("[A-Z]{5}[0-9]{4}[A-Z]{1}")
        ],
      ),
      'dob': FormControl<DateTime>(
        validators: [Validators.required],
      ),
    },
  );

  @override
  Widget build(BuildContext context) {
    return DiyForm(
      title: "Enter PAN & Date of Birth",
      subtitle: "A PAN card is compulsory for investing in India",
      formGroup: panForm,
      child: Column(
        children: [
          ReactiveTextField(
            formControlName: "pan",
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.characters,
            decoration: const InputDecoration(
              labelText: "PAN",
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
                readOnly: true,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: "Date of Birth",
                  hintText: "Enter your Date of Birth",
                  suffixIconColor: AppColors.primaryAccent(context),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: AppColors.primaryAccent(context),
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
              getIt<ApiRepository>()
                  .validatePan(
                pan: panForm.control("pan").value,
                dob: panForm.control("dob").value,
              )
                  .then(
                (value) {
                  if (value != null) {
                    //SHOW pop up
                    print(value);
                    return true;
                  } else {
                    //TODO show error
                  }
                },
              );
              return false;
            },
          ),
        ],
      ),
    );
  }
}
