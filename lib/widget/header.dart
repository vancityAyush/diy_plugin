import 'package:diy/network/models/ui_status.dart';
import 'package:diy/network/oauth_service.dart';
import 'package:flutter/material.dart';

import '../diy.dart';

const kReadOnly = 'readOnly';

class Header extends StatelessWidget {
  const Header({super.key});

  // BottomSheetNavigator navigator = Get.find<BottomSheetNavigator>();

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              final UiStatus uiStatus = getIt<OAuthService>().uiStatus;
              Navigator.pushNamedAndRemoveUntil(
                  context, "/form/email", (route) => false,
                  arguments: {kReadOnly: true});
            },
            icon: const Icon(Icons.menu),
          ),
          Image(
            image: AssetImage(
                isLightMode ? 'assets/logo-light.png' : 'assets/logo-dark.png',
                package: "diy"),
            height: 40,
            fit: BoxFit.cover,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.power_settings_new),
          ),
        ],
      ),
    );
  }
}
