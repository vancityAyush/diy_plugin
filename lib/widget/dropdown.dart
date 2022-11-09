import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/theme_files/app_colors.dart';

class DropDown extends StatelessWidget {
  DropDown(
      {Key? key, this.items = const ['Father', 'Mother', 'Spouse', 'Child']})
      : super(key: key);

  final List<String> items;
  final Rx<String?> selected = ''.obs;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Obx(
        () {
          return DropdownButton<String>(
            dropdownColor: AppColors.background(context),
            value: selected.value!.isEmpty ? null : selected.value,
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: TextStyle(
                        color: AppColors.primaryColor(context),
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              selected.value = value!;
            },
            hint: Text(
              'Myself',
              style: TextStyle(
                color: AppColors.primaryColor(context),
              ),
            ),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.primaryColor(context),
            ),
          );
        },
      ),
    );
  }
}
