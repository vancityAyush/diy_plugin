import 'package:diy/widget/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../diy.dart';
import '../../../network/api_repository.dart';
import '../../../utils/theme_files/app_colors.dart';
import '../../../widget/button_state.dart';
import '../../../widget/header.dart';
import '../../../widget/navigator/navigation_controller.dart';
import '../../../widget/textfield.dart';

class EnterPAN extends StatelessWidget {
  //TextEditingController dateinput = TextEditingController();
  final ApiRepository apiRepository = getIt<ApiRepository>();
  final isReadOnly;
  String PanName = '';
  EnterPAN({Key? key, this.isReadOnly = false}) : super(key: key);
  final PressedState pressController = Get.put(PressedState());

  final TextEditingController inputDate = TextEditingController();
  final TextEditingController paninput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Header(),
            const TitleText(text: 'Enter PAN & Date of\nBirth'),
            SizedBox(
              height: 20,
            ),
            SubtitleText(
                text: 'A PAN card is compulsory for investing in India.'),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: MyTextField(
              controller: paninput,
              hint: 'Enter PAN Number',
            )),
            MyTextField(
              hint: "YYYY-MM-DD",
              controller: inputDate,
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.calendar_month_rounded,
                  color: AppColors.primaryColor(context),
                ),
                onPressed: () async {
                  // DateTime? pickedDate = await showDatePicker(
                  //     context: context, //context of current state
                  //     initialDate: DateTime(2001),
                  //     firstDate: DateTime(
                  //         1950), //DateTime.now() - not to allow to choose before today.
                  //     lastDate: DateTime(2022));

                  // if (pickedDate != null) {
                  //   print(
                  //       pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  //   String formattedDate =
                  //       DateFormat('yyyy-MM-dd').format(pickedDate);
                  //   print(
                  //       formattedDate); //formatted date output using intl package =>  2021-03-16
                  // } else {
                  //   print("Date is not selected");
                  // }
                },
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context, //context of current state
                    initialDate: DateTime(2001),
                    firstDate: DateTime(
                        1950), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2022),
                    builder: (context, picker) {
                      return Theme(
                        //TODO: change colors
                        data: ThemeData(),
                        child: picker!,
                      );
                    }).then((selectedDate) {
                  //TODO: handle selected date
                  if (selectedDate != null) {
                    inputDate.text = selectedDate.toString();
                  }
                });

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                } else {
                  print("Date is not selected");
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 55,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    if (paninput.text.length != 10 || paninput.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Please enter valid PAN Number",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      apiRepository
                          .validatePan(pan: paninput.text, dob: inputDate.text)
                          .then(
                        (value) {
                          //  if (value =! ) {
                          Fluttertoast.showToast(
                              msg: "PAN Validation Completed",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);

                          showMaterialModalBottomSheet(
                            context: context,
                            builder: (context) => SingleChildScrollView(
                              controller: ModalScrollController.of(context),
                              child: Container(
                                color: AppColors.background(context),
                                height: 300,
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CircleAvatar(
                                        radius: 60,
                                        backgroundColor:
                                            AppColors.background(context),
                                        child: Icon(
                                          Icons.account_circle_sharp,
                                          color:
                                              AppColors.primaryAccent(context),
                                          size: 100,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Hello, Name',
                                        style: TextStyle(
                                            color: AppColors.primaryContent(
                                                context),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: SizedBox(
                                          height: 40,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15.0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: AppColors.primaryColor(
                                                    context),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, 'pageseven');
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text('Confirm name on PAN'),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Icon(Icons.arrow_forward),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Incorrect PAN?',
                                            style: TextStyle(
                                                color: AppColors.primaryAccent(
                                                    context)),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Re-enter PAN',
                                                style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor(
                                                            context)),
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                          // } else {
                          //   Fluttertoast.showToast(
                          //       msg: value.message,
                          //       toastLength: Toast.LENGTH_SHORT,
                          //       gravity: ToastGravity.BOTTOM,
                          //       timeInSecForIosWeb: 1,
                          //       backgroundColor: Colors.red,
                          //       textColor: Colors.white,
                          //       fontSize: 16.0);
                          // }
                        },
                      );
                    }

                    //navigate to page 6 i.e PAN name confirmation
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.primaryColor(context),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            const FooterText(),
            SizedBox(height: 20),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
