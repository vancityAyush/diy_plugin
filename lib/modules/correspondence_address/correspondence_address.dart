import 'package:diy/diy.dart';
import 'package:diy/modules/form_service.dart';
import 'package:diy/utils/libs.dart';
import 'package:diy/utils/util.dart';
import 'package:diy/widget/diy_form.dart';
import 'package:diy/widget/next_button.dart';
import 'package:diy/widget/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../utils/theme_files/app_colors.dart';
import 'models/country_dropdown.dart';

class Correspondence_address extends StatelessWidget {
  bool isReadOnly;
  Correspondence_address({Key? key, this.isReadOnly = false}) : super(key: key);

  final correspondenceAddress = getIt<FormService>().correspondence_address;
  @override
  Widget build(BuildContext context) {
    return DiyForm(
      title: 'Correspondence \nAddress',
      subtitle: 'Lorem ipsum dolor sit amet, consectetur \n adipiscing elit,',
      formGroup: correspondenceAddress,
      child: Column(
        children: [
          RichText(
              text: TextSpan(children: [
            WidgetSpan(
              child: FutureBuilder(
                future: getIt<ApiRepository>().getCountryDropDown(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: ReactiveDropdownField(
                        formControlName: 'Country',
                        hint: Text('Select Country',
                            style: TextStyle(
                                color: AppColors.primaryColor(context),
                                fontWeight: FontWeight.w700)),
                        iconSize: 30,
                        iconEnabledColor: AppColors.primaryColor(context),
                        iconDisabledColor: AppColors.primaryContent(context),
                        items: [
                          for (CountryDropdown item in snapshot.data)
                            DropdownMenuItem(
                              value: item.CountryId,
                              child: Text(
                                item.CountryName,
                                style: TextStyle(
                                  color: AppColors.primaryContent(context),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              alignment: Alignment.bottomLeft,
                            )
                        ],
                        elevation: 0,
                        dropdownColor: AppColors.background(context),
                        validationMessages: {
                          'required': (error) => 'Please Select a Country',
                        },
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ])),
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
          WidgetHelper.verticalSpace,
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
          ReactiveTextField(
            cursorColor: AppColors.primaryColor(context),
            formControlName: 'State',
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
              hintText: 'State',
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
            },
          ),
          WidgetHelper.verticalSpace20,
          ReactiveTextField(
            cursorColor: AppColors.primaryColor(context),
            formControlName: 'Country',
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
              hintText: 'Country',
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
            },
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
