import 'package:diy/utils/libs.dart';
import 'package:diy/widget/BottomPage.dart';
import 'package:flutter/material.dart';

import '../../diy.dart';
import '../../network/api_repository.dart';

class KycSelect extends StatelessWidget {
  bool isReadOnly;
  KycSelect({Key? key, this.isReadOnly = false}) : super(key: key);

  final apiRepository = getIt<ApiRepository>();

  @override
  Widget build(BuildContext context) {
    return BottomPage(
      title: "Personal details &\n document proofs",
      subtitle:
          "Use one of the following options for submitting your personal details & associated proofs",
      child: FutureBuilder(
        future: apiRepository.settings(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final res = snapshot.data as Map<String, dynamic>;
            return Column(
              children: [
                Visibility(
                  visible: res["EnableDigiLocker"],
                  child: buildCard(
                    context,
                    "Share using Aadhaar via Digilocker",
                    "Sign in and use your Digilocker account",
                    () {
                      Navigator.popAndPushNamed(context, '/form/digilocker');
                    },
                  ),
                ),
                // Visibility(
                //   visible: res["EnableOfflineAadhar"],
                //   child: buildCard(
                //     context,
                //     "Share offline Aadhaar",
                //     "Keep your Aadhaar number, PAN card ready`",
                //     () {},
                //   ),
                // ),
                Visibility(
                  visible: res["EnableManual"],
                  child: buildCard(
                    context,
                    "Enter your personal details manually",
                    "Keep your Pan card, address proof, photo ready for upload",
                    () async {
                      await getIt<ApiRepository>().manualJourney();
                      await getIt<OAuthService>().updateUiStatus().then(
                            (route) => Navigator.pushNamedAndRemoveUntil(
                              context,
                              route,
                              (route) => false,
                            ),
                          );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor(context),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildCard(
      BuildContext context, String text, String subtitle, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      height: 80.sp,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: MaterialButton(
        elevation: 0,
        onPressed: onTap,
        color: AppColors.textFieldBackground(context),
        minWidth: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                color: AppColors.subHeading(context),
                fontSize: 17.sp,
                height: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            WidgetHelper.verticalSpace5,
            Text(
              subtitle,
              style: TextStyle(
                color: AppColors.textColorTextField(context),
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
