import 'package:diy/utils/libs.dart';
import 'package:flutter/material.dart';

import '../../diy.dart';
import '../../utils/theme_files/app_colors.dart';
import '../../widget/diy_form.dart';
import '../form_service.dart';

class KycSelect extends StatelessWidget {
  KycSelect({Key? key}) : super(key: key);

  final settings = getIt<FormService>().settings;
  @override
  Widget build(BuildContext context) {
    return DiyForm(
      title: "Select KYC Type",
      subtitle: "Please select the type of KYC you want to perform",
      formGroup: settings,
      child: Column(
        children: [
          FutureBuilder<dynamic>(
              future: getIt<ApiRepository>().settings(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor(context),
                    ),
                  );
                }
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.textFieldBackground(context),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ReactiveCheckboxListTile(
                    formControlName: 'SelectKyc',
                    //value: 'pan',
                    title: const Text('Share using Aadhar via DigiLocker'),
                    subtitle:
                        const Text('Signin and use your Digilocker Account'),
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                );
              }),
          WidgetHelper.verticalSpace,
          Visibility(
            visible: settings.contains('EnableManual'),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.textFieldBackground(context),
                borderRadius: BorderRadius.circular(4),
              ),
              child: ReactiveCheckboxListTile(
                formControlName: 'EnableManual',
                //value: 'pan',
                title: const Text('Share offline Aadhaar'),
                subtitle:
                    const Text('Keep your Aadhaar number, PAN card ready'),
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          WidgetHelper.verticalSpace,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.textFieldBackground(context),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ReactiveCheckboxListTile(
              formControlName: 'EnableOfflineAadhar',
              //value: 'pan',
              title: const Text('Enter your personal details manually'),
              subtitle:
                  const Text('Keep your PAN card, address proof, photo ready'),
              checkboxShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          WidgetHelper.verticalSpace,
          NextButton(
            text: "Next",
            onPressed: () async {
              final res = await getIt<OAuthService>().updateUiStatus().then(
                    (route) => Navigator.pushNamedAndRemoveUntil(
                      context,
                      route,
                      (route) => false,
                    ),
                  );
              print(res);
              return true;
            },
          )
        ],
      ),
    );
  }
}
