import 'package:diy/modules/ifsc/ui/search_bank_location.dart';
import 'package:diy/utils/libs.dart';
import 'package:flutter/material.dart';

class SelectIFSCPage extends StatelessWidget {
  SelectIFSCPage({Key? key}) : super(key: key);

  final selectIfscForm = getIt<FormService>().selectIfscForm;

  @override
  Widget build(BuildContext context) {
    return DiyForm(
      formGroup: selectIfscForm,
      title: "Select IFSC Code",
      child: FutureBuilder<List<dynamic>>(
        future: getIt<ApiRepository>().getBankNames(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor(context),
              ),
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WidgetHelper.verticalSpace20,
              ReactiveDropdownField(
                formControlName: 'bank',
                items: snapshot.data!
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style: TextStyle(
                            color: AppColors.primaryContent(
                              context,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                style: TextStyle(
                  color: AppColors.primaryContent(context),
                ),
                decoration: InputDecoration(
                  filled: AppColors.textFieldBackground(context) != null,
                  labelText: 'Bank Name',
                  labelStyle:
                      TextStyle(color: AppColors.primaryContent(context)),
                  hintText: 'Enter Your Bank Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor(context),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  prefixIcon: Icon(
                    Icons.account_balance,
                    color: AppColors.primaryColor(context),
                  ),
                ),
                showErrors: (control) => control.invalid && control.dirty,
                validationMessages: {
                  'required': (error) => 'Please Enter Bank Name',
                },
              ),
              WidgetHelper.verticalSpace20,
              ReactiveTextField(
                formControlName: 'location',
                keyboardType: TextInputType.emailAddress,
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
                  labelText: 'Bank Location',
                  labelStyle:
                      TextStyle(color: AppColors.primaryContent(context)),
                  hintText: 'Enter Bank Location',
                  prefixIcon: Icon(
                    Icons.location_city,
                    color: Theme.of(context).primaryColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                showErrors: (control) => control.invalid && control.dirty,
                validationMessages: {
                  'required': (error) => 'Please Enter Bank Location',
                },
              ),
              WidgetHelper.verticalSpace20,
              NextButton(
                text: "Search",
                onPressed: () async {
                  await getIt<ApiRepository>()
                      .getIFSC(
                    bankName: selectIfscForm.control('bank').value,
                    location: selectIfscForm.control('location').value,
                  )
                      .then(
                    (value) async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SearchBankLocation(
                              banks: value,
                            );
                          },
                        ),
                      );
                      Navigator.pop(context);
                    },
                  );
                  return true;
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
