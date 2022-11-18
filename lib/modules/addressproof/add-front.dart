import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../utils/theme_files/app_colors.dart';
import '../../utils/util.dart';
import '../../widget/header.dart';
import '../../widget/next_button.dart';
import '../../widget/textfield.dart';
import '../../widget/textstyle.dart';

class AddFront extends StatefulWidget {
  const AddFront({super.key});

  @override
  State<AddFront> createState() => _AddFrontState();
}

final TextEditingController __addController = TextEditingController();

class _AddFrontState extends State<AddFront> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Header(
              showLogout: false,
            ),
            const SizedBox(height: 20),
            const TitleText(
              text: 'AdressProof-Front',
            ),
            const SizedBox(height: 20),
            MyTextField(
              hint: "Enter Phone",
              controller: __addController,
              keyboardType: TextInputType.phone,
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    '+91',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryContent(context)),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '|',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryContent(context),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const SubtitleText(text: "You will receive an OTP on your number"),
            const SizedBox(height: 30),
            NextButton(
              text: "Continue",
              onPressed: () async {
                // String? err;
                // String? route;
                // if (__phoneController.text.length != 10) {
                //   err = "Please enter a valid phone number";
                // }
                // if (isSwitched.value == false) {
                //   err = "Please accept the terms and conditions";
                // }
                // if (err != null) {
                //   AppUtil.showErrorToast(err);
                //   return null;
                // } else {
                //   await _oAuthService.sendOtp(__phoneController.text).then(
                //     (value) {
                //       if (value.success) {
                //         AppUtil.showToast("OTP sent successfully");
                //         route = "/otp";
                //       } else {
                //         AppUtil.showErrorToast(value.message);
                //       }
                //     },
                //   );
                // }
                // return route;
              },
            ),
            const SizedBox(height: 10),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text:
                          "I understand and authorize JM Financial Services\nto contact me via SMS, Calls, and WhatsApp\nfor all future communication   ",
                      style: TextStyle(
                        color: AppColors.primaryAccent(context),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: "T&Cs",
                          style: TextStyle(
                            color: AppColors.primaryColor(context),
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("T&C");
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FooterText(),
            const SizedBox(height: 20),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
