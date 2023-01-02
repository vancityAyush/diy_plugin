import 'package:diy/network/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../diy.dart';
import '../utils/theme_files/app_colors.dart';

typedef ApiCallback = Future<bool> Function();

class NextButton extends StatelessWidget {
  final ApiRepository apiRepository = getIt<ApiRepository>();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final String text;
  final Color? color;
  final ApiCallback onPressed;
  final bool validateForm;
  NextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
    this.validateForm = true,
  }) : super(key: key);

  Future<void> _onClick1(form) async {
    _btnController.start();
    if (form!.valid || !validateForm) {
      bool res = await onPressed();
      if (res) {
        _btnController.success();
      } else {
        _btnController.error();
      }
    } else {
      form.markAllAsTouched();
      _btnController.error();
    }
    Future.delayed(Duration(seconds: 2), () {
      _btnController.reset();
    });
  }

  Future<void> _onClick2() async {
    _btnController.start();
    bool res = await onPressed();
    if (res) {
      _btnController.success();
    } else {
      _btnController.error();
    }
    Future.delayed(Duration(seconds: 2), () {
      _btnController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RoundedLoadingButton(
        borderRadius: 4,
        color: color ?? AppColors.primaryColor(context),
        controller: _btnController,
        onPressed: () async {
          try {
            if (form != null) {
              await _onClick1(form);
            } else {
              await _onClick2();
            }
          } catch (e) {
            _btnController.error();
            Future.delayed(Duration(seconds: 2), () {
              _btnController.reset();
            });
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
