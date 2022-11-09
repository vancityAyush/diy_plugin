import 'package:flutter/material.dart';

import '../utils/theme_files/app_colors.dart';

class NextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;

  const NextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: AppColors.primaryColor(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      height: 50,
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
    );
  }
}
