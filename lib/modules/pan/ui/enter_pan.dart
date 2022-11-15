import 'package:diy/widget/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../diy.dart';
import '../../../network/api_repository.dart';
import '../../../utils/theme_files/app_colors.dart';
import '../../../utils/util.dart';
import '../../../widget/button_state.dart';
import '../../../widget/header.dart';
import '../../../widget/textfield.dart';

class EnterPAN extends StatelessWidget {
  //TextEditingController dateinput = TextEditingController();
  final ApiRepository apiRepository = getIt<ApiRepository>();
  final isReadOnly;
  String PanName = '';
  EnterPAN({Key? key, this.isReadOnly = false}) : super(key: key);
  final PressedState pressController = Get.put(PressedState());

  DateTime? dob;
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
            const TitleText(text: 'Enter PAN & Date of\nBirth '),
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
              ),
            ),
            MyTextField(
              onChanged: (value) {
                try {
                  dob = DateTime.parse(value ?? "");
                } catch (e) {}
              },
              hint: "YYYY-MM-DD",
              controller: inputDate,
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.calendar_month_rounded,
                  color: AppColors.primaryColor(context),
                ),
                onPressed: () async {
                  dob = await AppUtil.pickDate(context);
                  inputDate.text = DateFormat('yyyy-MM-dd').format(dob!);
                },
              ),
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
                    if (dob == null) {
                      AppUtil.showErrorToast(
                          'Please select a valid date of birth');
                    }
                    if (paninput.text.length != 10 || paninput.text.isEmpty) {
                      AppUtil.showErrorToast('Please enter a valid PAN number');
                    } else {
                      apiRepository
                          .validatePan(pan: paninput.text, dob: dob!)
                          .then(
                        (value) async {
                          //Show dialog pop up
                          bool res = await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                content: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
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
                                        color: AppColors.primaryAccent(context),
                                        size: 100,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Hello, ${value["FirstName"]} ${value["LastName"]}',
                                      style: TextStyle(
                                          color:
                                              AppColors.primaryContent(context),
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
                                              apiRepository
                                                  .validateKra(
                                                      value["PAN"],
                                                      value["DateOfBirth"],
                                                      value["KraVerified"],
                                                      value["PanVerified"],
                                                      value["FirstName"],
                                                      value["MiddleName"],
                                                      value["LastName"],
                                                      value["UAN"])
                                                  .then((value) async {
                                                AppUtil.showToast(
                                                        'PAN Verified Succesffully')
                                                    .then({
                                                  Navigator.pop(context, true)
                                                });
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
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
                                            Navigator.pop(context, false);
                                          },
                                          child: Text(
                                            'Re-enter PAN',
                                            style: TextStyle(
                                                color: AppColors.primaryColor(
                                                    context)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                          if (res) {
                            AppUtil.showToast('PAN verified successfully');
                          } else {
                            AppUtil.showErrorToast('PAN verification failed');
                          }

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
