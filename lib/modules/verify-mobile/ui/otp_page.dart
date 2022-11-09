import 'package:diy/diy.dart';
import 'package:diy/network/api_repository.dart';
import 'package:diy/network/oauth_service.dart';
import 'package:diy/widget/dropdown.dart';
import 'package:diy/widget/navigator/navigation_controller.dart';
import 'package:diy/widget/next_button.dart';
import 'package:diy/widget/pin.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../utils/theme_files/app_colors.dart';
import '../../../widget/header.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  bool timer = false;

  final OAuthService _oAuthService = getIt<OAuthService>();
  final ApiRepository _apiRepository = getIt<ApiRepository>();
  final navigator = Get.find<BottomSheetNavigator>();

  final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var arguments = Get.find<BottomSheetNavigator>().arguments;
    RxBool isSwitched = false.obs;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Header(),
            const SizedBox(height: 20),
            Text(
              'Verification code',
              style: TextStyle(
                color: AppColors.primaryContent(context),
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'We have sent the code verifcation to\n your Mobile Number',
                style: TextStyle(
                  color: AppColors.primaryAccent(context),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  getIt<OAuthService>().response["Mobile"],
                  style: TextStyle(
                      color: AppColors.primaryContent(context), fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: IconButton(
                      color: AppColors.primaryContent(context),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        size: 18,
                      )),
                )
              ],
            ),
            const SizedBox(height: 20),
            CodePin(
              pinController: pinController,
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                child: Countdown(
                  seconds: 30,
                  build: (BuildContext context, time) => Text(time.toString()),
                  interval: const Duration(seconds: 1),
                  onFinished: () {
                    setState(() {
                      timer = true;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 3),
            TextButton(
              onPressed: () {
                if (timer == true) {
                  null;
                  //code to send the code again
                } else {
                  null;
                }
              },
              child: Text(
                "Resend OTP",
                style: TextStyle(
                    color: AppColors.primaryColor(context), fontSize: 18),
              ),
            ),
            const SizedBox(height: 8),
            NextButton(
                text: "Verify",
                onPressed: () async {
                  if (pinController.text.length == 4) {
                    final res =
                        await _oAuthService.verifyOtp(pinController.text);
                    if (res.success) {
                      Fluttertoast.showToast(
                          msg: "OTP Verified",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      navigator.pushNamed('/form-email');
                    } else {
                      Fluttertoast.showToast(
                          msg: "Invalid OTP",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please Enter OTP",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: isSwitched.value,
                      onChanged: (val) {
                        isSwitched.value = val!;
                      },
                      side: BorderSide(
                        color: AppColors.primaryColor(context),
                      ),
                      activeColor: AppColors.primaryColor(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(
                          color: AppColors.primaryColor(context),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "I hereby declare that the mobile number",
                          style: TextStyle(
                              color: AppColors.primaryAccent(context),
                              fontSize: 15),
                          textAlign: TextAlign.left,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "belong to ",
                              style: TextStyle(
                                  color: AppColors.primaryAccent(context),
                                  fontSize: 15),
                              textAlign: TextAlign.left,
                            ),
                            DropDown()
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Text(
              "Lorem ipsum | Lorem ipsum | Lorem ipsum\nCopyrights @ 2022 © Blink Trude. All Right Reserved",
              style: TextStyle(
                color: AppColors.primaryAccent(context),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
