import 'package:diy/diy.dart';
import 'package:diy/modules/verify-mobile/models/relation_dropdown.dart';
import 'package:diy/network/api_repository.dart';
import 'package:diy/network/oauth_service.dart';
import 'package:diy/utils/util.dart';
import 'package:diy/widget/diy_form.dart';
import 'package:diy/widget/next_button.dart';
import 'package:diy/widget/pin.dart';
import 'package:diy/widget/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../utils/theme_files/app_colors.dart';

class OtpPage extends StatelessWidget {
  final String phoneNumber;
  OtpPage({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  final otpForm = FormGroup(
    {
      'otp': FormControl<String>(
        validators: [Validators.required],
      ),
      'TnC': FormControl<bool>(validators: [Validators.requiredTrue]),
      'relation': FormControl<int>(
        validators: [Validators.required],
      ),
    },
  );

  @override
  Widget build(BuildContext context) {
    return DiyForm(
      title: 'Verify Your Mobile Number',
      subtitle: "Please enter the OTP sent to your Mobile Number",
      formGroup: otpForm,
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '+91',
                  style: TextStyle(
                    color: AppColors.primaryContent(context),
                    fontSize: 16.sp,
                  ),
                ),
                TextSpan(
                  text: phoneNumber + "  ",
                  style: TextStyle(
                    color: AppColors.primaryContent(context),
                    fontSize: 16.sp,
                  ),
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.edit,
                      color: AppColors.primaryContent(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          WidgetHelper.verticalSpace20,
          CodePin(
            onChanged: (value) {
              otpForm.control('otp').value = value;
            },
          ),
          WidgetHelper.verticalSpace20,
          GestureDetector(
            onTap: () async {
              await getIt<OAuthService>().sendOtp(phoneNumber).then(
                (value) {
                  if (value.success) {
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
          WidgetHelper.verticalSpace20,
          NextButton(
            text: "Verify",
            onPressed: () async {
              if (otpForm.valid) {
                final res = await getIt<OAuthService>().verifyOtp(
                  otpForm.control('otp').value,
                  relationId: otpForm.control('relation').value,
                );
                if (res.success) {
                  AppUtil.showToast("OTP verified successfully");
                  return true;
                } else {
                  AppUtil.showToast("Something went wrong");
                  return false;
                }
              } else {
                AppUtil.showErrorToast("Please enter OTP");
                return false;
              }
            },
          ),
          WidgetHelper.verticalSpace20,
          ReactiveCheckboxListTile(
            formControlName: 'TnC',
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'I hereby declare that the mobile number belongs to ',
                    style: TextStyle(
                      color: AppColors.primaryContent(context),
                      fontSize: 14.sp,
                    ),
                  ),
                  WidgetSpan(
                    child: FutureBuilder(
                      future: getIt<ApiRepository>().getRelationDropDown(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ReactiveDropdownField(
                            hint: const Text('Select Relation'),
                            items: [
                              for (RelationDropdown item in snapshot.data)
                                DropdownMenuItem(
                                  value: item.RelationId,
                                  child: Text(
                                    item.RelationName,
                                    style: TextStyle(
                                      color: AppColors.primaryContent(context),
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                )
                            ],
                            formControlName: 'relation',
                            elevation: 0,
                            dropdownColor: AppColors.background(context),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            validationMessages: {
                              'required': (error) => 'Please Select a Relation',
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
