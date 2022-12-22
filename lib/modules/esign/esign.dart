import 'package:diy/utils/libs.dart';
import 'package:diy/widget/BottomPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../diy.dart';
import '../../network/api_repository.dart';

class ESign extends StatelessWidget {
  bool isReadOnly;

  ESign({Key? key, this.isReadOnly = false}) : super(key: key);

  final apiRepository = getIt<ApiRepository>();

  @override
  Widget build(BuildContext context) {
    return BottomPage(
        title: "E-Sign",
        child: Column(
          children: [
            Column(
              children: [
                WidgetHelper.verticalSpace,
                Text(
                  'You are just a step away from submitting\nthe form for verification.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.subHeading(context), fontSize: 16.sp),
                ),
                WidgetHelper.verticalSpace20,
                Text(
                  'Your details captured in the previous\nscreens need to be digitally signed for\nauthenticity.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.subHeading(context), fontSize: 16.sp),
                ),
                WidgetHelper.verticalSpace20,
                RichText(
                  text: TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'You may',
                      ),
                      TextSpan(
                          text: ' click here ',
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () => print('Tap Here onTap'),
                          style: TextStyle(
                              color: AppColors.primaryColor(context),
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                        text:
                            'and download the\npre-filled form before proceeding to\ne-signing the document. ',
                      )
                    ],
                    style: TextStyle(
                        color: AppColors.subHeading(context), fontSize: 16.sp),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: NextButton(
                  text: ' E-Sign Now',
                  onPressed: () async {
                    return false;
                  }),
            ),
          ],
        ));
  }
}
