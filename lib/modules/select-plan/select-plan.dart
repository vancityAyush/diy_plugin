import 'package:diy/utils/libs.dart';
import 'package:diy/widget/BottomPage.dart';
import 'package:flutter/material.dart';

import '../../diy.dart';
import '../../network/api_repository.dart';

class SelectPlan extends StatelessWidget {
  bool isReadOnly;

  SelectPlan({Key? key, this.isReadOnly = false}) : super(key: key);

  final apiRepository = getIt<ApiRepository>();

  @override
  Widget build(BuildContext context) {
    return BottomPage(
        title: "Select a Plan",
        subtitle: "Select Trading Segment",
        child: Center(
          child: Container(
            height: WidgetsBinding.instance.window.physicalSize.height / 6,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryAccent(context),
                          surfaceTintColor: AppColors.primaryColor(context),
                        ),
                        onPressed: () {},
                        child: Text('     Cash + MF     ')),
                    WidgetHelper.horizontalSpace20,
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryAccent(context),
                        ),
                        onPressed: () {},
                        child: Text('Cash + MF + F&O')),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: NextButton(
                        text: ' E-Sign Now',
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
