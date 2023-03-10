import 'package:diy/utils/libs.dart';
import 'package:diy/widget/BottomPage.dart';
import 'package:diy/widget/web_view_2.dart';
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
                    () async {
                      final res = await apiRepository.digiLocker();
                      final data = res["Data"] as List<dynamic>;
                      final m = getIt<OAuthService>().currentUser!.Mobile!;
                      final url =
                          "https://newdiy.cloudyhr.com/diy/digio?m=$m&env=${data[0]}&id=${data[1]}&t=${data[2]}";
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebViewApp(url: url)));
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
