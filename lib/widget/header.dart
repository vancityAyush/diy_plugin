import 'package:flutter/material.dart';

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
            onPressed: () {},
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
