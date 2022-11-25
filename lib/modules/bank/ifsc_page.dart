import 'package:diy/diy.dart';
import 'package:diy/network/api_repository.dart';
import 'package:diy/widget/diy_form.dart';
import 'package:diy/widget/next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../utils/theme_files/app_colors.dart';
import '../../widget/widget_helper.dart';
import '../form_service.dart';

class IFSCPage extends StatelessWidget {
  final bool isReadOnly;
  IFSCPage({Key? key, this.isReadOnly = false}) : super(key: key);

  final ifscForm = getIt<FormService>().ifscForm;

  @override
  Widget build(BuildContext context) {
    if (!isReadOnly) {
      ifscForm.reset();
    }
    return DiyForm(
      title: "Link Your Bank Account",
      formGroup: ifscForm,
      child: Column(
        children: [
          ReactiveTextField(
            readOnly: isReadOnly,
            formControlName: 'ifsc',
            keyboardType: TextInputType.emailAddress,
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
              labelText: 'IFSC Code',
              labelStyle: TextStyle(color: AppColors.primaryContent(context)),
              hintText: 'Enter Your IFSC Code',
              prefixIcon: Icon(
                Icons.account_balance,
                color: Theme.of(context).primaryColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            showErrors: (control) => control.invalid && control.dirty,
            validationMessages: {
              'required': (error) => 'Please Enter IFSC',
            },
          ),
          WidgetHelper.verticalSpace20,
          TextButton(
            onPressed: () async {
              List<dynamic> banks = await getIt<ApiRepository>().getBankNames();
              final selectIfscForm = FormGroup({
                'bank': FormControl<String>(
                  validators: [Validators.required],
                ),
                'location': FormControl<String>(
                  validators: [Validators.required],
                ),
              });
              await showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: ReactiveForm(
                      formGroup: selectIfscForm,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Search IFSC code",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryContent(context),
                            ),
                          ),
                          WidgetHelper.verticalSpace20,
                          ReactiveDropdownField(
                            formControlName: 'bank',
                            items: banks
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        color: AppColors.primaryContent(
                                          context,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            style: TextStyle(
                              color: AppColors.primaryContent(context),
                            ),
                            decoration: InputDecoration(
                              labelText: 'Bank Name',
                              labelStyle: TextStyle(
                                  color: AppColors.primaryContent(context)),
                              hintText: 'Enter Your Bank Name',
                            ),
                            showErrors: (control) =>
                                control.invalid && control.dirty,
                            validationMessages: {
                              'required': (error) => 'Please Enter Bank Name',
                            },
                          ),
                          WidgetHelper.verticalSpace20,
                          ReactiveTextField(
                            formControlName: 'location',
                            keyboardType: TextInputType.emailAddress,
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
                              labelText: 'Bank Location',
                              labelStyle: TextStyle(
                                  color: AppColors.primaryContent(context)),
                              hintText: 'Enter Bank Location',
                              prefixIcon: Icon(
                                Icons.location_city,
                                color: Theme.of(context).primaryColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            showErrors: (control) =>
                                control.invalid && control.dirty,
                            validationMessages: {
                              'required': (error) =>
                                  'Please Enter Bank Location',
                            },
                          ),
                          WidgetHelper.verticalSpace20,
                          NextButton(
                            text: "Search",
                            onPressed: () async {
                              final res = await getIt<ApiRepository>().getIFSC(
                                bankName: selectIfscForm.control('bank').value,
                                location:
                                    selectIfscForm.control('location').value,
                              );
                              return true;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Text(
              "Search IFSC Code",
              style: TextStyle(
                color: AppColors.primaryColor(context),
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
