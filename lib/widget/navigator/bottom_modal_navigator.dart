import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'navigation_controller.dart';

class BottomModalNavigator extends GetView<BottomSheetNavigator> {
  const BottomModalNavigator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !controller.pop();
      },
      child: Obx(
        () => controller.currentScreen,
      ),
    );
  }
}
