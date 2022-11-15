import 'package:diy/utils/theme_files/app_colors.dart';
import 'package:diy/widget/navigator/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../diy.dart';
import 'navigator/bottom_modal_navigator.dart';

class Header extends StatelessWidget {
  BottomSheetNavigator navigator = Get.find<BottomSheetNavigator>();
  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: AppBar(
        backgroundColor: AppColors.background(context),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            navigator.pop();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: AppColors.primaryAccent(context),
          ),
        ),
        title: Image(
          image: AssetImage(
              isLightMode ? 'assets/logo-light.png' : 'assets/logo-dark.png',
              package: "diy"),
          height: 150,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final call = Uri.parse('tel:+91 8149284177');
              if (await canLaunchUrl(call)) {
                launchUrl(call);
              } else {
                throw 'Could not launch $call';
              }
            },
            icon: Icon(
              Icons.call_outlined,
              size: 25,
              color: AppColors.primaryAccent(context),
            ),
          ),
          const SizedBox(width: 15),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.power_settings_new_rounded,
              size: 25,
              color: AppColors.primaryAccent(context),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
