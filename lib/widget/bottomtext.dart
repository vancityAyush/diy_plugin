import 'package:flutter/material.dart';

class BottomText extends StatelessWidget {
  const BottomText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            "Lorem ipsum | Lorem ipsum | Lorem ipsum",
            style: TextStyle(color: Colors.white30),
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            "Copyrights @ 2002 © blinktrade. All rights reserved",
            style: TextStyle(color: Colors.white30),
          ),
        ),
      ],
    );
  }
}
