import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../diy.dart';
import '../../utils/libs.dart';
import '../../widget/diy_form.dart';
import '../form_service.dart';

class UploadIpv extends StatelessWidget {
  bool isReadOnly;
  UploadIpv({Key? key, this.isReadOnly = false}) : super(key: key);

  final uploadIpvForm = getIt<FormService>().uploadIpvForm;
  @override
  Widget build(BuildContext context) {
    return DiyForm(
      formGroup: uploadIpvForm,
      title: "Mobile cam IPV",
      subtitle: "Let's do a quick in-person-verification over web cam",
      child: Column(
        children: [
          WidgetHelper.verticalSpace20,
          ReactiveTextField(
            readOnly: isReadOnly,
            formControlName: 'ipvCode',
            keyboardType: TextInputType.number,
            cursorColor: AppColors.primaryColor(context),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              filled: AppColors.textFieldBackground(context) != null,
              fillColor: AppColors.textFieldBackground(context),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.textFieldBackground(context),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primaryColor(context),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              // labelText: 'Email ID',
              // labelStyle:
              //     TextStyle(color: AppColors.primaryContent(context)),

              hintText: '3436',
              hintStyle: TextStyle(
                  color: AppColors.primaryContent(context),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700),
              // prefixIcon: Icon(
              //   Icons.email_outlined,
              //   color: Theme.of(context).primaryColor,
              // ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            showErrors: (control) => control.invalid && control.hasFocus,
            validationMessages: {},
          ),
          WidgetHelper.verticalSpace20,
          if (isReadOnly)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.primaryColor(context),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    showCustomDialog(context);
                  },
                  child: Row(
                    children: const [
                      Spacer(),
                      Text(
                        'Capture',
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
              ),
            ),
          if (!isReadOnly)
            Align(
              alignment: Alignment.bottomCenter,
              child: NextButton(
                text: "Next",
                onPressed: () async {
                  showCustomDialog(context);
                  return false;
                },
              ),
            )
        ],
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (dialogContext) {
        return Center(
          child: Container(
            height: WidgetsBinding.instance.window.physicalSize.height / 6,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.background(context),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _getCloseButton(context),
                WidgetHelper.verticalSpace20,
                Center(
                  child: Text(
                    "Captured and verified\nsuccessfully!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                WidgetHelper.verticalSpace20,
                SvgPicture.asset(
                  "packages/diy/assets/security.svg",
                  color: AppColors.textColorTextField(context),
                ),
                WidgetHelper.verticalSpace20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: NextButton(
                    text: "Next",
                    validateForm: false,
                    onPressed: () async {
                      try {
                        //await getIt<ApiRepository>().validateKra(kraForm.value);

                        return true;
                      } catch (e) {
                        return false;
                      } finally {
                        Navigator.pop(dialogContext);
                        await getIt<OAuthService>().updateUiStatus().then(
                              (newRoute) => Navigator.pushNamedAndRemoveUntil(
                                  context, newRoute, (route) => false),
                            );
                      }
                    },
                  ),
                ),
                WidgetHelper.verticalSpace20,
                RichText(
                  text: TextSpan(
                    text: "Incorrect Pan ?",
                    style: TextStyle(
                      color: AppColors.primaryContent(context),
                      fontSize: 16.sp,
                    ),
                    children: [
                      TextSpan(
                        text: "Re-enter PAN",
                        style: TextStyle(
                          color: AppColors.primaryColor(context),
                          fontSize: 16.sp,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pop();
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _getCloseButton(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          alignment: FractionalOffset.topRight,
          child: GestureDetector(
            child: Icon(
              Icons.close,
              color: AppColors.primaryContent(context),
            ),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop('dialog');
            },
          ),
        ),
      ),
    );
  }
}
