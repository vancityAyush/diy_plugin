import 'package:flutter/material.dart';

import '../../diy.dart';
import '../../utils/libs.dart';
import '../../utils/theme_files/app_colors.dart';
import '../../utils/util.dart';
import '../../widget/diy_form.dart';
import '../form_service.dart';

class BankAccountNumber extends StatelessWidget {
  final bool isReadOnly;
  BankAccountNumber({Key? key, this.isReadOnly = false}) : super(key: key);
  final selectbankAccountForm = getIt<FormService>().bankAccountForm;
  @override
  Widget build(BuildContext context) {
    return DiyForm(
      formGroup: selectbankAccountForm,
      title: 'Verify Bank Account',
      child: Column(
        children: [
          ReactiveTextField(
            readOnly: isReadOnly,
            formControlName: 'BankAccountNo',
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
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
              //labelText: 'Bank Account Number',
              labelStyle: TextStyle(color: AppColors.primaryContent(context)),
              hintText: 'Enter Bank Account Number',
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
            maxLength: 11,
            showErrors: (control) => control.invalid && control.dirty,
            validationMessages: {
              'required': (error) => 'Please Enter Bank Account Number',
              'minLength': (error) =>
                  'The Bank Account Number must have at least 11 characters',
            },
          ),
          WidgetHelper.verticalSpace20,
          Align(
            alignment: Alignment.bottomCenter,
            child: NextButton(
              text: "Next",
              validateForm: false,
              onPressed: () async {
                // final val = getIt<OAuthService>().currentUser;
                // selectbankAccountForm.control('CustomerId').value(val);
                final res = await getIt<ApiRepository>()
                    .validateBankAcc(selectbankAccountForm.value)
                    .then((res) async {
                  if (res.status) {
                    AppUtil.showToast("Bank Account Verified");
                    selectbankAccountForm.value = res;
                    await getIt<OAuthService>().updateUiStatus().then(
                          (route) => Navigator.pushNamedAndRemoveUntil(
                            context,
                            route,
                            (route) => false,
                          ),
                        );
                    return true;
                  } else {
                    AppUtil.showToast("Something went wrong");
                  }
                });

                return false;
              },
            ),
          ),
        ],
      ),
    );
  }
}
