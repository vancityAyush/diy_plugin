import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/theme_files/app_colors.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: AppBar(
        backgroundColor: AppColors.background(context),
        elevation: 0,
        leading: Icon(
          Icons.arrow_back,
          size: 25,
          color: AppColors.primaryAccent(context),
        ),
        title: Image.asset(
          isLightMode ? 'assets/logo-light.png' : 'assets/logo-dark.png',
          width: 150,
        ),
        actions: [
          Icon(
            Icons.call_outlined,
            size: 25,
            color: AppColors.primaryAccent(context),
          ),
          const SizedBox(width: 15),
          Icon(
            Icons.power_settings_new_rounded,
            size: 25,
            color: AppColors.primaryAccent(context),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
