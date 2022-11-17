import 'package:diy/network/api_repository.dart';
import 'package:diy/widget/navigator/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../diy.dart';
import '../utils/theme_files/app_colors.dart';

typedef ApiCallback = Future<String?> Function();

class NextButton extends StatelessWidget {
  final ApiRepository apiRepository = getIt<ApiRepository>();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final String text;
  final Color? color;
  final ApiCallback onPressed;
  NextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RoundedLoadingButton(
        borderRadius: 4,
        resetAfterDuration: true,
        resetDuration: const Duration(seconds: 2),
        color: color ?? AppColors.primaryColor(context),
        controller: _btnController,
        onPressed: () async {
          _btnController.start();
          String? nextRoute = await onPressed();
          if (nextRoute != null) {
            _btnController.success();
            Get.find<BottomSheetNavigator>().pushNamed(nextRoute);
          } else {
            _btnController.error();
          }
        },
        child: Row(
          children: [
            const Spacer(),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
