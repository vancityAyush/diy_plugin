import 'package:flutter/material.dart';

class Check_Boxs extends StatefulWidget {
  const Check_Boxs({Key? key}) : super(key: key);

  @override
  State<Check_Boxs> createState() => _Check_BoxsState();
}

class _Check_BoxsState extends State<Check_Boxs> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = false;

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
