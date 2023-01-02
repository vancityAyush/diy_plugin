import 'package:diy/diy.dart';
import 'package:diy/modules/ifsc/ui/search_bank_location.dart';
import 'package:diy/modules/ifsc/ui/select_ifsc_page.dart';
import 'package:diy/utils/libs.dart';
import 'package:diy/utils/util.dart';
import 'package:diy/widget/diy_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../utils/theme_files/app_colors.dart';
import '../../../widget/widget_helper.dart';
import '../../form_service.dart';
import '../models/bank.dart';

class IFSCPage extends StatelessWidget {
  final bool isReadOnly;
  IFSCPage({Key? key, this.isReadOnly = false}) : super(key: key);

  final ifscForm = getIt<FormService>().ifscForm;

  @override
  Widget build(BuildContext context) {
    return DiyForm(
      title: "Verify Bank Account",
      subtitle: "Lorem ipsum dolor sit amet, consectetur",
      formGroup: ifscForm,
      child: Column(
        children: [
          ReactiveTextField(
            readOnly: isReadOnly,
            formControlName: 'ifsc',
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
              filled: AppColors.textFieldBackground(context) != null,
              fillColor: AppColors.textFieldBackground(context),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.textFieldBackground(context),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primaryColor(context),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              // labelText: 'IFSC Code',
              labelStyle: TextStyle(color: AppColors.primaryContent(context)),
              hintText: 'Enter Your IFSC Code',
              // prefixIcon: Icon(
              //   Icons.account_balance,
              //   color: Theme.of(context).primaryColor,
              // ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            showErrors: (control) => control.invalid && control.dirty,
            validationMessages: {
              'required': (error) => 'Please Enter IFSC',
              'minLength': (error) =>
                  'The IFSC Code must have at least 11 characters',
            },
          ),
          WidgetHelper.verticalSpace20,
          Visibility(
            visible: !isReadOnly,
            child: TextButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SelectIFSCPage();
                    },
                  ),
                );
              },
              child: Text(
                "Search IFSC Code",
                style: TextStyle(
                  color: AppColors.primaryColor(context),
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: NextButton(
              text: "Search",
              onPressed: () async {
                List<bank> banks = await getIt<ApiRepository>()
                    .getIfscFromCode(ifscForm.control('ifsc').value);
                if (banks.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SearchBankLocation(banks: banks);
                      },
                    ),
                  );
                  return true;
                } else {
                  AppUtil.showToast("No Bank Found");
                  return false;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
