import 'package:diy/diy.dart';
import 'package:diy/network/oauth_service.dart';
import 'package:diy/widget/navigator/navigation_controller.dart';
import 'package:diy/widget/next_button.dart';
import 'package:diy/widget/textfield.dart';
import 'package:diy/widget/textstyle.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../utils/theme_files/app_colors.dart';
import '../../../widget/button_state.dart';
import '../../../widget/header.dart';

class SignUpPage extends StatelessWidget {
  final OAuthService _oAuthService = getIt<OAuthService>();
  final isReadOnly;
  final PressedState pressController = Get.put(PressedState());
  final TextEditingController __phoneController = TextEditingController();
  final isLogged = false.obs;
  SignUpPage({Key? key, this.isReadOnly = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return SafeArea(
      child: SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Header(),
            const SizedBox(height: 20),
            const TitleText(
              text: 'Signup Now',
            ),
            const SizedBox(height: 20),
            MyTextField(
              hint: "Enter Phone",
              controller: __phoneController,
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
            SubtitleText(text: "You will receive an OTP on your number"),
            const SizedBox(height: 30),
            Obx(() {
              return pressController.isLoading.isTrue
                  ? NextButton(
                      text: "Continue",
                      onPressed: () {
                        if (__phoneController.text.length != 10 ||
                            __phoneController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Please enter valid phone number",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          pressController.changeStatus();
                          _oAuthService.sendOtp(__phoneController.text).then(
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
                                Get.find<BottomSheetNavigator>()
                                    .pushNamed('/otp');
                                pressController.changeStatus();
                              } else {
                                Fluttertoast.showToast(
                                    msg: value.message,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                pressController.changeStatus();
                              }
                            },
                          );
                        }
                      },
                    )
                  : LoadingNextButton(text: "Continue");
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
            FooterText(),
            const SizedBox(height: 20),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
