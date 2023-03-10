import 'package:diy/modules/select-plan/models/plan.dart';
import 'package:diy/utils/libs.dart';
import 'package:flutter/material.dart';
import 'package:reactive_segmented_control/reactive_segmented_control.dart';

import '../../diy.dart';
import '../../network/api_repository.dart';

class SelectPlan extends StatelessWidget {
  bool isReadOnly;

  SelectPlan({Key? key, this.isReadOnly = false}) : super(key: key);
  final apiRepository = getIt<ApiRepository>();

  final selectPlanForm = getIt<FormService>().selectPlan;

  @override
  Widget build(BuildContext context) {
    return DiyForm(
      title: "Select a Plan",
      subtitle: "Select Trading Segment",
      formGroup: selectPlanForm,
      child: Column(
        children: [
          WidgetHelper.verticalSpace20,
          ReactiveSegmentedControl(
            children: const {
              1: Text("Cash + MTF"),
              2: Text("Cash + MTF + F&O"),
            },
            formControlName: "PlanType",
          ),
          ReactiveValueListenableBuilder<int>(
            builder: (context, value, child) {
              return FutureBuilder<List<plan>>(
                future: apiRepository.getPlans(value.value!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ReactiveRadioListTile<int>(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data![index].Title,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              for (var item in snapshot.data![index].Features)
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16.sp,
                                    ),
                                    WidgetHelper.horizontalSpace,
                                    Text(item),
                                  ],
                                )
                            ],
                          ),
                          value: snapshot.data![index].PlanId,
                          formControlName: "PlanId",
                        );
                      },
                    );
                  }
                  return Text(value.toString());
                },
              );
            },
            formControlName: "PlanType",
          ),
          WidgetHelper.verticalSpace20,
          ReactiveCheckboxListTile(
            title: Text("DDPI"),
            formControlName: "DdpiOpted",
          ),
          WidgetHelper.verticalSpace20,
          Align(
            alignment: Alignment.bottomCenter,
            child: NextButton(
              text: "Next",
              onPressed: () async {
                // showCustomDialog(context);
                await apiRepository.savePlanDetails(selectPlanForm.value);
                await getIt<OAuthService>().updateUiStatus().then(
                      (route) => Navigator.pushNamedAndRemoveUntil(
                        context,
                        route,
                        (route) => false,
                      ),
                    );
                return true;
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
            height: WidgetsBinding.instance.window.physicalSize.height / 3.75,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.background(context),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView(
              children: [
                _getCloseButton(context),
                WidgetHelper.verticalSpace20,
                Center(
                  child: Text(
                    "Plan Details",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                WidgetHelper.verticalSpace20,
                DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => AppColors.background(context)),
                  columns: const [
                    DataColumn(
                        label: Text(
                      ' Particular ',
                    )),
                    DataColumn(
                        label: Text(
                      '   Charges Per Order   ',
                    )),
                  ],
                  rows: [
                    DataRow(
                        color: MaterialStateColor.resolveWith(
                            (states) => AppColors.secondaryColor(context)),
                        cells: [
                          DataCell(Text('Futures')),
                          DataCell(
                            Center(child: Text('??? 20')),
                          ),
                        ]),
                    DataRow(
                        color: MaterialStateColor.resolveWith(
                            (states) => AppColors.background(context)),
                        cells: [
                          DataCell(Text('Options')),
                          DataCell(
                            Center(child: Text('??? 20')),
                          ),
                        ]),
                    DataRow(
                        color: MaterialStateColor.resolveWith(
                            (states) => AppColors.secondaryColor(context)),
                        cells: [
                          DataCell(Text('Equity Intraday')),
                          DataCell(
                            Center(child: Text('??? 20')),
                          ),
                        ]),
                    DataRow(
                        color: MaterialStateColor.resolveWith(
                            (states) => AppColors.background(context)),
                        cells: [
                          DataCell(Text('Currency F&O')),
                          DataCell(
                            Center(child: Text('??? 20')),
                          ),
                        ]),
                  ],
                ),
                Divider(),
                WidgetHelper.verticalSpace20,
                Center(
                    child: Text(
                  'Terms & Conditions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                Center(
                    child: Text(
                  '*???299 plus 18% GST would be debited towards one\ntime subscription fee for\nBlinktrade',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 2),
                )),
                WidgetHelper.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 20.0),
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
              ],
            ),
          ),
        );
      },
    );
  }

  _getCloseButton(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
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
