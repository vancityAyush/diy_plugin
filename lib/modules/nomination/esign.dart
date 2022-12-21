import 'package:diy/utils/libs.dart';
import 'package:diy/widget/BottomPage.dart';
import 'package:flutter/material.dart';

import '../../diy.dart';
import '../../network/api_repository.dart';

class Nomination extends StatelessWidget {
  bool isReadOnly;

  Nomination({Key? key, this.isReadOnly = false}) : super(key: key);

  final apiRepository = getIt<ApiRepository>();

  @override
  Widget build(BuildContext context) {
    return BottomPage(
        title: "Nomination",
        child: Center(
          child: Container(
            height: WidgetsBinding.instance.window.physicalSize.height / 6,
            child: Stack(
              children: [
                ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => AppColors.primaryColor(context)),
                      columnSpacing: 30.sp,
                      columns: [
                        DataColumn(
                            label: Text('Nominee',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Relation',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Contact',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Share',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                      ],
                      rows: [
                        DataRow(
                            color: MaterialStateColor.resolveWith((states) =>
                                AppColors.textFieldBackground(context)),
                            cells: [
                              DataCell(Text('1')),
                              DataCell(Text('Name')),
                              DataCell(Text('8149284177')),
                              DataCell(Text('Asang')),
                            ]),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: NextButton(
                      text: 'Continue',
                      onPressed: () async {
                        return false;
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
