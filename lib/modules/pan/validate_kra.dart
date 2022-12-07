import 'package:diy/diy.dart';
import 'package:diy/network/oauth_service.dart';
import 'package:diy/utils/theme_files/app_colors.dart';
import 'package:diy/widget/diy_form.dart';
import 'package:diy/widget/next_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../network/api_repository.dart';
import '../../widget/widget_helper.dart';
import '../form_service.dart';

class ValidateKra extends StatelessWidget {
  final bool isReadOnly;
  ValidateKra({Key? key, this.isReadOnly = false}) : super(key: key);
  final kraForm = getIt<FormService>().validatePanForm;

  @override
  Widget build(BuildContext context) {
    return DiyForm(
      formGroup: kraForm,
      child: Column(
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
          Text(
            "Hello, ${kraForm.control('FirstName').value} ${kraForm.control('MiddleName').value} ${kraForm.control('LastName').value}",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          WidgetHelper.verticalSpace20,
          NextButton(
            text: "Confirm name on PAN",
            validateForm: false,
            onPressed: () async {
              try {
                await getIt<ApiRepository>().validateKra(kraForm.value);
                return true;
              } catch (e) {
                return false;
              } finally {
                await getIt<OAuthService>().updateUiStatus().then(
                      (newRoute) => Navigator.pushNamedAndRemoveUntil(
                          context, newRoute, (route) => false),
                    );
              }
            },
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
    );
  }
}
