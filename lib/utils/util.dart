import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum DOCTYPE {
  BankProof,
  PanPhoto,
  Signature,
  AddressProofFrontSide,
  AddressProofBackSide,
  Selfie,
  IPV,
  AOF,
  Photo,
  IncomeProo,
  PromoCodeProof,
  KRAAOF
}

Map<DOCTYPE, int> uploadMap = {
  DOCTYPE.BankProof: 7,
  DOCTYPE.PanPhoto: 8,
  DOCTYPE.Signature: 9,
  DOCTYPE.AddressProofFrontSide: 18,
  DOCTYPE.AddressProofBackSide: 19,
  DOCTYPE.Selfie: 20,
  DOCTYPE.IPV: 23,
  DOCTYPE.AOF: 24,
  DOCTYPE.Photo: 26,
  DOCTYPE.IncomeProo: 27,
  DOCTYPE.PromoCodeProof: 28,
  DOCTYPE.KRAAOF: 36,
};

class AppUtil {
  static pickDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
  }

  static pageBuilder(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static showErrorToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(255, 90, 9, 3),
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
