import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../utils/theme_files/app_colors.dart';

class PaySent extends StatefulWidget {
  const PaySent({Key? key}) : super(key: key);

  @override
  State<PaySent> createState() => _PaySentState();
}

class _PaySentState extends State<PaySent> {
  bool timer = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: AppColors.background(context),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "We are depositing ₹1 in \nyour bank account to \nverify it",
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Icon(
            Icons.timer_outlined,
            size: 120,
            color: AppColors.primaryAccent(context),
          ),
          Countdown(
            seconds: 30,
            build: (BuildContext context, time) => Text(
              time.toString(),
              style: TextStyle(color: AppColors.primaryContent(context)),
            ),
            interval: Duration(seconds: 1),
            onFinished: () {
              setState(() {
                timer = true;
              });
            },
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'This will take 28 seconds',
            style: TextStyle(
              color: AppColors.primaryContent(context),
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor(context),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'doc_proof');
                  //code to send the code again
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Next',
                      style: TextStyle(
                        //color: AppColors.textColor,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      //color: AppColors.textColor,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
