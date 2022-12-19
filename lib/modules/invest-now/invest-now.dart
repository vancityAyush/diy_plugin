import 'package:diy/utils/libs.dart';
import 'package:diy/widget/BottomPage.dart';
import 'package:flutter/material.dart';

class InvestNow extends StatelessWidget {
  bool isReadOnly;

  InvestNow({Key? key, this.isReadOnly = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomPage(
        title: "Congratulations",
        child: Center(
          child: Container(
            height: WidgetsBinding.instance.window.physicalSize.height / 6,
            child: Column(
              children: [
                WidgetHelper.verticalSpace,
                Image.asset(
                  "packages/diy/assets/congratulation.png",
                  width: 200.sp,
                ),
                WidgetHelper.verticalSpace,
                Text(
                  'Congratulations {Name}!',
                  style: TextStyle(
                      color: AppColors.primaryContent(context),
                      fontSize: 16.sp),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: NextButton(
                        text: "Let's Start",
                        onPressed: () async {
                          return false;
                        }),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
