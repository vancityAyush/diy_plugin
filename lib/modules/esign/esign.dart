import 'package:diy/utils/libs.dart';
import 'package:diy/widget/BottomPage.dart';
import 'package:diy/widget/web_view_2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../diy.dart';
import '../../network/api_repository.dart';

class ESign extends StatefulWidget {
  bool isReadOnly;

  ESign({Key? key, this.isReadOnly = false}) : super(key: key);

  @override
  State<ESign> createState() => _ESignState();
}

class _ESignState extends State<ESign> {
  final apiRepository = getIt<ApiRepository>();

  @override
  void initState() {
    if (!widget.isReadOnly) {
      apiRepository.generateKra();
    }
    super.initState();
  }

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
                    const TextSpan(
                      text: 'You may',
                    ),
                    TextSpan(
                        text: ' click here ',
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => print('Tap Here onTap'),
                        style: TextStyle(
                            color: AppColors.primaryColor(context),
                            fontWeight: FontWeight.bold)),
                    const TextSpan(
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
                validateForm: false,
                onPressed: () async {
                  final res = await apiRepository.startESign();
                  final data = res["Data"] as List<dynamic>;
                  final m = getIt<OAuthService>().currentUser!.Mobile!;
                  final url =
                      "https://newdiy.cloudyhr.com/diy/digio?m=$m&env=${data[0]}&id=${data[1]}&t=${data[2]}";
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebViewApp(url: url)));
                  await getIt<OAuthService>().updateUiStatus().then(
                        (route) => Navigator.pushNamedAndRemoveUntil(
                          context,
                          route,
                          (route) => false,
                        ),
                      );
                  return true;
                }),
          ),
        ],
      ),
    );
  }
}
