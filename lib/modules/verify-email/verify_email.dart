import 'package:diy/network/api_repository.dart';
import 'package:diy/network/oauth_service.dart';
import 'package:diy/utils/util.dart';
import 'package:diy/widget/navigator/navigation_controller.dart';
import 'package:diy/widget/next_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../diy.dart';
import '../../utils/theme_files/app_colors.dart';
import '../../widget/header.dart';
import '../../widget/pin.dart';
import '../../widget/textstyle.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool timer = false;
  RxBool isSwitched = false.obs;
  ApiRepository apiRepository = getIt<ApiRepository>();
  BottomSheetNavigator navigator = Get.find<BottomSheetNavigator>();
  final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final arguments = Get.find<BottomSheetNavigator>().arguments;
    print(arguments);
    return SafeArea(
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Header(),
          TitleText(text: 'Verification code'),
          const SizedBox(height: 20),
          SubtitleText(
            text: 'We have sent the code verifcation to\n your email address ',
          ),
          SizedBox(height: 20),
          CodePin(
            pinController: pinController,
          ),
          SizedBox(height: 20),
          Center(
            child: Container(
              child: Countdown(
                seconds: 30,
                build: (BuildContext context, time) => Text(time.toString()),
                interval: Duration(seconds: 1),
                onFinished: () {
                  setState(() {
                    timer = true;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 3),
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
          SizedBox(height: 8),
          NextButton(
              text: 'Verify',
              color: AppColors.primaryColor(context),
              onPressed: () async {
                String? route;
                if (pinController.text.length == 4) {
                  apiRepository
                      .validateEmail(
                    email: arguments["Email"],
                    otp: pinController.text,
                    refId: arguments["RefId"],
                    relationId: arguments["EmailRelationshipId"],
                  )
                      .then(
                    (value) async {
                      if (value != null) {
                        route = await getIt<OAuthService>().updateUiStatus();
                      } else {
                        AppUtil.showErrorToast("Invalid OTP");
                      }
                    },
                  );
                } else {
                  print('error');
                }
                return null;
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
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "I hereby declare that the email address",
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
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FooterText(),
          SizedBox(height: 20),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      )),
    );
  }
}
