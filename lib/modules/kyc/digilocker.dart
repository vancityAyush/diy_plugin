import 'package:diy/utils/libs.dart';
import 'package:diy/widget/BottomPage.dart';
import 'package:flutter/material.dart';

class SelectDigilocker extends StatelessWidget {
  const SelectDigilocker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool dummy = true;
    return BottomPage(
        title: 'Share Aadhaar\nWith Digilocker',
        // subtitle:
        //     'Share a digital copy (name, gender, DoB, address, and photo) of your Asdhaar from your Govt. Digilocker account for KYC. Your 12 gidit Aadhaar number is never revealed or collected. The Aadhaar and the PAN GZJ1254A could belong to you.',
        child: Column(
          children: [
            Text(
              'Share a digital copy (name, gender, DoB, address, and photo) of your Asdhaar from your Govt. Digilocker account for KYC. Your 12 gidit Aadhaar number is never revealed or collected. The Aadhaar and the PAN GZJ1254A could belong to you.',
              style: TextStyle(color: AppColors.subHeading(context)),
            ),
          ],
        ));
  }
}
