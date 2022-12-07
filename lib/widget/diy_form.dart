import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'BottomPage.dart';

class DiyForm extends StatelessWidget {
  final FormGroup formGroup;
  final Widget child;
  final Widget? terms;
  final String? title;
  final String? subtitle;
  const DiyForm(
      {Key? key,
      required this.child,
      this.title,
      this.subtitle,
      this.terms,
      required this.formGroup})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: formGroup,
      child: BottomPage(
        title: title,
        subtitle: subtitle,
        child: child,
      ),
    );
  }
}
