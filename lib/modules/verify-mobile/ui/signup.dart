import 'package:diy/diy.dart';
import 'package:diy/network/oauth_service.dart';
import 'package:diy/widget/header.dart';
import 'package:diy/widget/navigator/navigation_controller.dart';
import 'package:diy/widget/next_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../utils/theme_files/app_colors.dart';
import '../../../widget/textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final phoneController = TextEditingController();
  bool readOnly = false;

  final OAuthService _oAuthService = getIt<OAuthService>();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return SafeArea(
      child: SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Header(),
              //Header()
              const Text(
                'Signup Now',
                style: TextStyle(
                  //color: AppColors.textColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 40),
              MyTextField(
                hint: "Enter Phone",
                controller: phoneController,
                keyboardType: TextInputType.phone,
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      '+91',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
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
              Text(
                "You will receive an OTP on your number",
                style: TextStyle(
                  color: AppColors.primaryAccent(context),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 30),
              NextButton(
                  text: "Continue",
                  onPressed: () {
                    if (phoneController.text.length != 10 ||
                        phoneController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Please enter valid phone number",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      _oAuthService.sendOtp(phoneController.text).then(
                        (value) {
                          if (value.success) {
                            Fluttertoast.showToast(
                                msg: "OTP sent successfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Get.find<BottomSheetNavigator>().pushNamed('/otp');
                          } else {
                            Fluttertoast.showToast(
                                msg: value.message,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                      );
                    }
                  }),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: AppColors.primaryColor(context),
                    ),
                    child: Checkbox(
                      value: true,
                      onChanged: (val) {},
                      activeColor: AppColors.primaryColor(context),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                              color: AppColors.primaryAccent(context))),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Enable WhatsApp Notification ",
                      style: TextStyle(
                        color: AppColors.primaryAccent(context),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: "T&Cs",
                          style: TextStyle(
                            color: AppColors.primaryColor(context),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
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
              Text(
                "Lorem ipsum | Lorem ipsum | Lorem ipsum\nCopyrights @ 2022 © Blink Trude. All Right Reserved",
                style: TextStyle(
                  color: AppColors.primaryAccent(context),
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      ),
    );
  }
}
