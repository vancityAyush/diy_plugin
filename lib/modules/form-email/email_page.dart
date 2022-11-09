import 'package:diy/widget/dropdown.dart';
import 'package:diy/widget/header.dart';
import 'package:diy/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';

import '../../utils/theme_files/app_colors.dart';

class EmailPage extends StatefulWidget {
  static String Email = '';

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  bool IsClicked = false;
  RxBool isSwitched = false.obs;

  void _onChanged(val) {
    setState(() {
      EmailPage.Email = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Header(),
            // const Spacer(
            //   flex: 1,
            // ),
            const SizedBox(height: 50),
            Text(
              'Enter Email Address',
              style: TextStyle(
                  fontSize: 28,
                  color: AppColors.primaryContent(context),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (IsClicked)
              Text('You will receive an OTP on your email',
                  style: TextStyle(
                      fontSize: 15,
                      color: AppColors.primaryAccent(context),
                      fontWeight: FontWeight.w400)),
            const SizedBox(height: 20),
            if (IsClicked)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.textFieldBackground(context),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: MyTextField(
                    hint: 'Enter Email',
                    label: "Email",
                    readOnly: true,
                    controller: TextEditingController(text: "anything"),
                    prefixIcon: Row(
                      children: const [
                        SizedBox(width: 10),
                        Icon(
                          Icons.email,
                        ),
                        SizedBox(width: 10),
                        Text("|"),
                      ],
                    ),
                  ),
                ),
              ),
            if (!IsClicked)
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SignInButton(
                          Buttons.Google,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          text: "Continue with Google",
                          onPressed: () {
                            setState(() {
                              IsClicked = true;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 5),
            if (!IsClicked)
              Text(
                'OR',
                style: TextStyle(
                  color: AppColors.primaryAccent(context),
                  fontSize: 20,
                ),
              ),
            SizedBox(height: IsClicked ? 20 : 5),
            if (IsClicked)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primaryColor(context),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/form-email');
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 108.0),
                      child: Row(children: const [
                        Text('Validate E-mail'),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward),
                      ]),
                    ),
                  ),
                ),
              ),
            if (!IsClicked)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.email_outlined),
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.primaryColor(context)),
                    onPressed: () {
                      setState(() {
                        IsClicked = true;
                      });
                    },
                    label: const Text('Enter email ID'),
                  ),
                ),
              ),
            const SizedBox(height: 40),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isSwitched.value,
                    onChanged: (val) {
                      isSwitched.value = val!;
                    },
                    side: BorderSide(
                      color: AppColors.primaryColor(context),
                    ),
                    activeColor: AppColors.primaryColor(context),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                        color: AppColors.primaryColor(context),
                      ),
                    ),
                  ),
                  Text(
                    "I understand and agree to allow JMFL to\ncontact me via Calls, SMSes and Emails for any\nfuture communication.",
                    style: TextStyle(
                        color: AppColors.primaryAccent(context), fontSize: 15),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            DropDown(),
            const SizedBox(height: 20),
            Text(
              "Lorem ipsum | Lorem ipsum | Lorem ipsum\nCopyrights @ 2022 © Blink Trude. All Right Reserved",
              style: TextStyle(
                color: AppColors.primaryAccent(context),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}