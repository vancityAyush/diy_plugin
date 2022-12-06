import 'package:diy/diy.dart';
import 'package:diy/modules/form_service.dart';
import 'package:diy/modules/verify-mobile/models/relation_dropdown.dart';
import 'package:diy/network/api_repository.dart';
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

class OtpPage extends StatelessWidget {
  final String phoneNumber;
  OtpPage({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  final otpForm = getIt<FormService>().otpForm;

  @override
  Widget build(BuildContext context) {
    return DiyForm(
      title: 'Verification Code',
      subtitle: "We have sent the code verification \nto your Mobile Number",
      formGroup: otpForm,
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '+91 ',
                  style: TextStyle(
                      color: AppColors.subHeading(context),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text: phoneNumber + "  ",
                  style: TextStyle(
                      color: AppColors.subHeading(context),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor(context),
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 15,
                        color: AppColors.background(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
                selectedColor: AppColors.primaryColor(context),
                inactiveColor: AppColors.primaryAccent(context),
                activeFillColor: AppColors.textFieldBackground(context),
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(4),
                activeColor: AppColors.primaryColor(context),
              ),
              showErrors: (control) => control.invalid && control.dirty,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          GestureDetector(
            onTap: () async {
              await getIt<OAuthService>().sendOtp(phoneNumber).then(
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
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          NextButton(
            text: "Verify",
            onPressed: () async {
              final res = await getIt<OAuthService>().verifyOtp(
                otpForm.control('otp').value,
                relationId: otpForm.control('relation').value,
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
          Row(
            children: [
              ReactiveCheckbox(
                activeColor: AppColors.primaryColor(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                formControlName: 'TnC',
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'I hereby declare that the mobile number belongs to ',
                    style: TextStyle(
                      color: AppColors.primaryContent(context),
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              )
            ],
          ),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: FutureBuilder(
                    future: getIt<ApiRepository>().getRelationDropDown(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: ReactiveDropdownField(
                            formControlName: 'relation',
                            hint: Text('Select Relation',
                                style: TextStyle(
                                    color: AppColors.primaryColor(context),
                                    fontWeight: FontWeight.w700)),
                            iconSize: 30,
                            iconEnabledColor: AppColors.primaryColor(context),
                            iconDisabledColor:
                                AppColors.primaryContent(context),
                            items: [
                              for (RelationDropdown item in snapshot.data)
                                DropdownMenuItem(
                                  value: item.RelationId,
                                  child: Text(
                                    item.RelationName,
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
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            validationMessages: {
                              'required': (error) => 'Please Select a Relation',
                            },
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
