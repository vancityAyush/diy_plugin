import 'package:diy/diy.dart';
import 'package:diy/modules/verify-mobile/models/relation_dropdown.dart';
import 'package:diy/network/api_repository.dart';
import 'package:diy/network/oauth_service.dart';
import 'package:diy/utils/util.dart';
import 'package:diy/widget/navigator/navigation_controller.dart';
import 'package:diy/widget/next_button.dart';
import 'package:diy/widget/pin.dart';
import 'package:diy/widget/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../utils/theme_files/app_colors.dart';
import '../../../widget/header.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  bool timer = false;

  final OAuthService _oAuthService = getIt<OAuthService>();
  final ApiRepository _apiRepository = getIt<ApiRepository>();
  final navigator = Get.find<BottomSheetNavigator>();
  //TODO removed final
  final Rx<int?> _selectedRelation = Rx<int?>(null);
  final TextEditingController pinController = TextEditingController();

  RxBool isVisible = true.obs;

  late int relation;

  @override
  void initState() {
    if (getIt<OAuthService>().response["AppExists"] == true) {
      relation = getIt<OAuthService>().response["MobileRelationshipId"];
      isVisible = false.obs;
    } else {
      isVisible = true.obs;
    }
    // TODO: implement initState
    super.initState();
  }

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
            TitleText(text: 'Verification code'),
            const SizedBox(height: 20),
            SubtitleText(
                text:
                    'We have sent the code verifcation to\n your Mobile Number'),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("0:"),
                    Countdown(
                      seconds: 30,
                      build: (BuildContext context, time) =>
                          Text(time.toString()),
                      interval: const Duration(seconds: 1),
                      onFinished: () {
                        setState(() {
                          timer = true;
                        });
                      },
                    ),
                  ],
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
              text: getIt<OAuthService>().response["AppExists"] == false
                  ? "Verify"
                  : "Resume Application",
              onPressed: () async {
                String? route;

                if (getIt<OAuthService>().response["AppExists"] == true) {
                  if (pinController.text.length == 4) {
                    final res = await _oAuthService
                        .verifyOtp(pinController.text, relationId: relation);
                    if (res.success) {
                      AppUtil.showToast("OTP Verified");
                      //TODO TESTING READONLY SCREENS
                      route = "/form/email";
                      //route = await _oAuthService.updateUiStatus();
                    }
                  } else if (pinController.text.length <= 4) {
                    AppUtil.showErrorToast("Please enter a valid OTP");
                  } else if (isSwitched.value == false) {
                    AppUtil.showErrorToast("Please select relationship.");
                  } else {
                    AppUtil.showErrorToast("Please Enter OTP");
                  }
                } else {
                  if (pinController.text.length == 4 && isSwitched.value) {
                    final res = await _oAuthService.verifyOtp(
                        pinController.text,
                        relationId: _selectedRelation.value ?? 1);
                    if (res.success) {
                      AppUtil.showToast("OTP Verified");
                      // route = "/form/email";
                      route = await _oAuthService.updateUiStatus();
                    }
                  } else if (pinController.text.length <= 4) {
                    AppUtil.showErrorToast("Please enter a valid OTP");
                  } else if (isSwitched.value == false) {
                    AppUtil.showErrorToast("Please select relationship.");
                  } else {
                    AppUtil.showErrorToast("Please Enter OTP");
                  }
                }

                return route;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(
                () => Visibility(
                  visible: isVisible.value,
                  child: Row(
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
                              FutureBuilder<List<RelationDropdown>>(
                                future: _apiRepository.getRelationDropDown(),
                                builder: (context, snapshot) {
                                  List<RelationDropdown> DropDownId = [];
                                  if (snapshot.hasData) {
                                    DropDownId =
                                        snapshot.data as List<RelationDropdown>;
                                  }
                                  return Obx(
                                    () => DropdownButtonHideUnderline(
                                      child: DropdownButton<int>(
                                        hint: Text(
                                          "SELF",
                                          style: TextStyle(
                                              color: AppColors.primaryColor(
                                                  context),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        value: _selectedRelation.value,
                                        items: DropDownId.map(
                                            (RelationDropdown item) {
                                          return DropdownMenuItem(
                                            value: item.RelationId,
                                            child: Text(
                                              item.RelationName,
                                              style: TextStyle(
                                                  color: AppColors.primaryColor(
                                                      context),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          print(value);
                                          _selectedRelation.value = value ?? 0;
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
