import 'package:diy/diy.dart';
import 'package:diy/modules/correspondence_address/models/country_dropdown_item.dart';
import 'package:diy/modules/correspondence_address/models/state_dropdown_item.dart';
import 'package:diy/modules/form_service.dart';
import 'package:diy/utils/libs.dart';
import 'package:diy/utils/util.dart';
import 'package:diy/widget/diy_form.dart';
import 'package:diy/widget/next_button.dart';
import 'package:diy/widget/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../utils/theme_files/app_colors.dart';

class Correspondence_address extends StatelessWidget {
  bool isReadOnly;
  Correspondence_address({Key? key, this.isReadOnly = false}) : super(key: key);

  final correspondenceAddress = getIt<FormService>().correspondence_address;
  @override
  Widget build(BuildContext context) {
    if (!isReadOnly) {
      correspondenceAddress.reset();
    }
    return DiyForm(
      title: 'Correspondence \nAddress',
      subtitle: 'Lorem ipsum dolor sit amet, consectetur \n adipiscing elit,',
      formGroup: correspondenceAddress,
      child: Column(
        children: [
          ReactiveTextField(
            cursorColor: AppColors.primaryColor(context),
            formControlName: 'House/bldg/block',
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
              hintText: 'House/bldg/block',
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
            formControlName: 'Street',
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
              hintText: 'Street',
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
            formControlName: 'Location',
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
              hintText: 'Location',
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
            formControlName: 'City',
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
              hintText: 'City',
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
            formControlName: 'PinCode',
            keyboardType: TextInputType.phone,
            maxLength: 7,
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
              hintText: 'Pin Code',
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
              'required': (error) => 'The Phone Number must not be empty',
              'minLength': (error) => 'The Pin Code must have 7 characters',
            },
          ),
          WidgetHelper.verticalSpace,
          Container(
            height: 55.sp,
            decoration: BoxDecoration(
                color: AppColors.textFieldBackground(context),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: FutureBuilder<List<StateDropdownItem>>(
                future: getIt<ApiRepository>().getStates(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<StateDropdownItem>> snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: ReactiveDropdownField(
                        dropdownColor: AppColors.background(context),
                        icon: Icon(Icons.arrow_drop_down),
                        items: snapshot.data!
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.StateName,
                                  style: TextStyle(
                                    color: AppColors.textColorTextField(
                                      context,
                                    ),
                                  ),
                                )))
                            .toList(),
                        formControlName: 'State',
                        style: TextStyle(
                          color: AppColors.textColorTextField(context),
                        ),
                        hint: Text('Select State',
                            style: TextStyle(
                              color: AppColors.textColorTextField(context),
                            )),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // filled: AppColors.textFieldBackground(context) != null,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        showErrors: (control) =>
                            control.invalid && control.dirty,
                        validationMessages: {
                          'required': (error) => 'Please Select State',
                        },
                        iconSize: 30,
                        iconEnabledColor: AppColors.primaryColor(context),
                        iconDisabledColor: AppColors.primaryContent(context),
                      ),
                    );
                  }
                  return Container(
                    height: 55.sp,
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        color: AppColors.textFieldBackground(context),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownMenuItem(
                      child: Text(
                        'Select State',
                        style: TextStyle(
                          color: AppColors.textColorTextField(
                            context,
                          ),
                        ),
                      ),
                    ),
                  );
                },
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
              child: FutureBuilder<List<CountryDropdownItem>>(
                future: getIt<ApiRepository>().getCountries(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<CountryDropdownItem>> snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: ReactiveDropdownField(
                        dropdownColor: AppColors.background(context),
                        icon: Icon(Icons.arrow_drop_down),
                        items: snapshot.data!
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.CountryName,
                                  style: TextStyle(
                                    color: AppColors.textColorTextField(
                                      context,
                                    ),
                                  ),
                                )))
                            .toList(),
                        formControlName: 'Country',
                        style: TextStyle(
                          color: AppColors.textColorTextField(context),
                        ),
                        hint: Text('Select Country',
                            style: TextStyle(
                              color: AppColors.textColorTextField(context),
                            )),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // filled: AppColors.textFieldBackground(context) != null,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        showErrors: (control) =>
                            control.invalid && control.dirty,
                        validationMessages: {
                          'required': (error) => 'Please Select Country',
                        },
                        iconSize: 30,
                        iconEnabledColor: AppColors.primaryColor(context),
                        iconDisabledColor: AppColors.primaryContent(context),
                      ),
                    );
                  }
                  return Container(
                    height: 55.sp,
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        color: AppColors.textFieldBackground(context),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownMenuItem(
                      child: Text(
                        'Select Country',
                        style: TextStyle(
                          color: AppColors.textColorTextField(
                            context,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          WidgetHelper.verticalSpace20,
          NextButton(
            text: "Continue",
            onPressed: () async {
              return await getIt<OAuthService>()
                  .sendOtp(
                correspondenceAddress.control('phone').value,
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
