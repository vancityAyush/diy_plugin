import 'package:flutter/material.dart';

import '../utils/theme_files/app_colors.dart';

class NextButton extends StatelessWidget {
  final String text;
  final Color? color;
  final VoidCallback? onPressed;
  NextButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: MaterialButton(
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
        ));
  }
}

class LoadingNextButton extends StatelessWidget {
  final String text;
  final Color? color;

  const LoadingNextButton({
    Key? key,
    required this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.primaryAccent(context),
            borderRadius: BorderRadius.all(Radius.circular(4))),
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
            SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: AppColors.background(context),
                strokeWidth: 1.8,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
