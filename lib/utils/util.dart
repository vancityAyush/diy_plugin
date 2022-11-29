import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum uploadType {
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

Map<uploadType, int> uploadMap = {
  uploadType.BankProof: 7,
  uploadType.PanPhoto: 8,
  uploadType.Signature: 9,
  uploadType.AddressProofFrontSide: 18,
  uploadType.AddressProofBackSide: 19,
  uploadType.Selfie: 20,
  uploadType.IPV: 23,
  uploadType.AOF: 24,
  uploadType.Photo: 26,
  uploadType.IncomeProo: 27,
  uploadType.PromoCodeProof: 28,
  uploadType.KRAAOF: 36,
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
