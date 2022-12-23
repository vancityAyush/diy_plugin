import 'package:diy/utils/libs.dart';
import 'package:flutter/material.dart';

import '../../diy.dart';
import '../../network/api_repository.dart';

class SelectPlan extends StatelessWidget {
  bool isReadOnly;

  SelectPlan({Key? key, this.isReadOnly = false}) : super(key: key);

  final apiRepository = getIt<ApiRepository>();
  final selectPlanForm = getIt<FormService>().selectPlan;

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return DiyForm(
        title: "Select a Plan",
        subtitle: "Select Trading Segment",
        formGroup: selectPlanForm,
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Trading Segment"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.3,
                        child: ReactiveCheckbox(
                            activeColor: AppColors.primaryColor(context),
                            formControlName: 'Segment1',
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            )),
                      ),
                      Text('Cash + MTF')
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.3,
                        child: ReactiveCheckbox(
                            activeColor: AppColors.primaryColor(context),
                            formControlName: 'Segment2',
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            )),
                      ),
                      Text('Cash + MTF + F&O')
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: ReactiveCheckboxListTile(
                  activeColor: AppColors.primaryColor(context),
                  formControlName: 'Segment1',
                  checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  title: Text(
                    'Cash + MTF',
                    style: TextStyle(
                      color: AppColors.primaryContent(context),
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('Selection');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.textFieldBackground(context),
                      border:
                          Border.all(color: AppColors.primaryColor(context)),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 10.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Transform.scale(
                              scale: 1.3,
                              child: ReactiveCheckbox(
                                activeColor: AppColors.primaryColor(context),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                formControlName: 'SelectedSegment1',
                              ),
                            ),
                            Text(
                              "DIY Standard",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          ListTile(
                            title: Text('Delivery at 0.25'),
                            leading: Icon(Icons.keyboard_arrow_right_rounded),
                            minLeadingWidth: 10,
                            visualDensity: VisualDensity(vertical: -4),
                          ),
                          ListTile(
                            title: Text('Intraday Free'),
                            leading: Icon(Icons.keyboard_arrow_right_rounded),
                            minLeadingWidth: 10,
                            visualDensity: VisualDensity(vertical: -4),
                          ),
                          ListTile(
                            title: Text('Future at 0.001'),
                            leading: Icon(Icons.keyboard_arrow_right_rounded),
                            minLeadingWidth: 10,
                            visualDensity: VisualDensity(vertical: -4),
                          ),
                          ListTile(
                            title: Text('Options Rs. 20 per Lot'),
                            leading: Icon(Icons.keyboard_arrow_right_rounded),
                            minLeadingWidth: 10,
                            visualDensity: VisualDensity(vertical: -4),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Center(
                          child: Text(
                            "Read More",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor(context)),
                          ),
                        ),
                        iconColor: AppColors.primaryColor(context),
                        collapsedIconColor: AppColors.primaryColor(context),
                        children: <Widget>[
                          DataTable(
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => AppColors.background(context)),
                            columns: [
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
                                      (states) => AppColors.textFieldBackground(
                                          context)),
                                  cells: [
                                    DataCell(Text('Futures')),
                                    DataCell(
                                      Center(child: Text('₹ 20')),
                                    ),
                                  ]),
                              DataRow(
                                  color: MaterialStateColor.resolveWith(
                                      (states) =>
                                          AppColors.background(context)),
                                  cells: [
                                    DataCell(Text('Options')),
                                    DataCell(
                                      Center(child: Text('₹ 20')),
                                    ),
                                  ]),
                              DataRow(
                                  color: MaterialStateColor.resolveWith(
                                      (states) => AppColors.textFieldBackground(
                                          context)),
                                  cells: [
                                    DataCell(Text('Equity Intraday')),
                                    DataCell(
                                      Center(child: Text('₹ 20')),
                                    ),
                                  ]),
                              DataRow(
                                  color: MaterialStateColor.resolveWith(
                                      (states) =>
                                          AppColors.background(context)),
                                  cells: [
                                    DataCell(Text('Currency F&O')),
                                    DataCell(
                                      Center(child: Text('₹ 20')),
                                    ),
                                  ]),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              WidgetHelper.verticalSpace,
              GestureDetector(
                onTap: () {
                  print('Selection');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.textFieldBackground(context),
                      border:
                          Border.all(color: AppColors.primaryColor(context)),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 10.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Transform.scale(
                              scale: 1.3,
                              child: ReactiveCheckbox(
                                activeColor: AppColors.primaryColor(context),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                formControlName: 'SelectedSegment2',
                              ),
                            ),
                            Text(
                              "DIY Standard",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          ListTile(
                            title: Text('Delivery at 0.25'),
                            leading: Icon(Icons.keyboard_arrow_right_rounded),
                            minLeadingWidth: 10,
                            visualDensity: VisualDensity(vertical: -4),
                          ),
                          ListTile(
                            title: Text('Intraday Free'),
                            leading: Icon(Icons.keyboard_arrow_right_rounded),
                            minLeadingWidth: 10,
                            visualDensity: VisualDensity(vertical: -4),
                          ),
                          ListTile(
                            title: Text('Future at 0.001'),
                            leading: Icon(Icons.keyboard_arrow_right_rounded),
                            minLeadingWidth: 10,
                            visualDensity: VisualDensity(vertical: -4),
                          ),
                          ListTile(
                            title: Text('Options Rs. 20 per Lot'),
                            leading: Icon(Icons.keyboard_arrow_right_rounded),
                            minLeadingWidth: 10,
                            visualDensity: VisualDensity(vertical: -4),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Center(
                          child: Text(
                            "Read More",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor(context)),
                          ),
                        ),
                        iconColor: AppColors.primaryColor(context),
                        collapsedIconColor: AppColors.primaryColor(context),
                        children: <Widget>[
                          DataTable(
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) =>
                                    AppColors.textColorTextField(context)),
                            columns: [
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
                                      (states) => AppColors.textFieldBackground(
                                          context)),
                                  cells: [
                                    DataCell(Text('Futures')),
                                    DataCell(
                                      Center(child: Text('₹ 20')),
                                    ),
                                  ]),
                              DataRow(
                                  color: MaterialStateColor.resolveWith(
                                      (states) => AppColors.textColorTextField(
                                          context)),
                                  cells: [
                                    DataCell(Text('Options')),
                                    DataCell(
                                      Center(child: Text('₹ 20')),
                                    ),
                                  ]),
                              DataRow(
                                  color: MaterialStateColor.resolveWith(
                                      (states) => AppColors.textFieldBackground(
                                          context)),
                                  cells: [
                                    DataCell(Text('Equity Intraday')),
                                    DataCell(
                                      Center(child: Text('₹ 20')),
                                    ),
                                  ]),
                              DataRow(
                                  color: MaterialStateColor.resolveWith(
                                      (states) => AppColors.textColorTextField(
                                          context)),
                                  cells: [
                                    DataCell(Text('Currency F&O')),
                                    DataCell(
                                      Center(child: Text('₹ 20')),
                                    ),
                                  ]),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: NextButton(
                    text: 'Next',
                    onPressed: () async {
                      return false;
                    }),
              )
            ],
          ),
        ));
  }
}
