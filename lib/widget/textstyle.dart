import 'package:flutter/material.dart';

import '../utils/theme_files/app_colors.dart';

class TitleText extends StatelessWidget {
  final String text;
  const TitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryContent(context)),
      textAlign: TextAlign.center,
    );
  }
}

class SubtitleText extends StatelessWidget {
  final String text;
  const SubtitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: AppColors.primaryAccent(context), fontSize: 15),
      textAlign: TextAlign.center,
    );
  }
}

class FooterText extends StatelessWidget {
  const FooterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        "Copyrights @ 2022 © Blink Trude. All Right Reserved",
        style: TextStyle(
          color: AppColors.primaryAccent(context),
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
