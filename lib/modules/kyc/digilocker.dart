import 'package:diy/utils/libs.dart';
import 'package:diy/widget/BottomPage.dart';
import 'package:flutter/material.dart';

import '../../utils/util.dart';

class SelectDigilocker extends StatelessWidget {
  const SelectDigilocker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool dummy = true;
    return BottomPage(
        title: 'Share Aadhaar\nWith Digilocker',
        // subtitle:
        //     'Share a digital copy (name, gender, DoB, address, and photo) of your Asdhaar from your Govt. Digilocker account for KYC. Your 12 gidit Aadhaar number is never revealed or collected. The Aadhaar and the PAN GZJ1254A could belong to you.',
        child: SizedBox(
          height: WidgetsBinding.instance.window.physicalSize.height / 5,
          child: Column(
            children: [
              Text(
                'Share a digital copy (name, gender, DoB, address, and photo) of your Asdhaar from your Govt. Digilocker account for KYC. Your 12 gidit Aadhaar number is never revealed or collected. The Aadhaar and the PAN GZJ1254A could belong to you.',
                style: TextStyle(color: AppColors.subHeading(context)),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: NextButton(
                    text: "Continue",
                    onPressed: () async {
                      return await getIt<ApiRepository>()
                          .settings(
                              //FinancialInfoForm.control('phone').value,
                              )
                          .then(
                        (res) {
                          if (res.status) {
                            AppUtil.showToast(
                              'OTP sent successfully',
                            );
                            return true;
                          } else {
                            AppUtil.showErrorToast(res.arguments);
                          }
                          return false;
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
