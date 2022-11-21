import 'package:diy/network/api_repository.dart';
import 'package:diy/network/oauth_service.dart';
import 'package:diy/utils/util.dart';
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
  final bool autoNavigate;
  NextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
    this.autoNavigate = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context);
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
          if (form!.valid) {
            bool res = await onPressed();
            if (res) {
              _btnController.success();
              if (autoNavigate) {
                await getIt<OAuthService>().updateUiStatus().then(
                    (value) => {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              value, (Route<dynamic> route) => false)
                        }, onError: (e) {
                  AppUtil.showErrorToast(e.toString());
                  _btnController.error();
                });
              }
            } else {
              _btnController.error();
            }
          } else {
            form.markAllAsTouched();
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
