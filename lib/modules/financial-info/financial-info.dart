import 'package:diy/diy.dart';
import 'package:diy/modules/financial-info/models/occupation_dropdown_item.dart';
import 'package:diy/modules/financial-info/models/trading_experience_dropdown_item.dart';
import 'package:diy/modules/form_service.dart';
import 'package:diy/utils/libs.dart';
import 'package:diy/utils/util.dart';
import 'package:diy/widget/diy_form.dart';
import 'package:diy/widget/next_button.dart';
import 'package:diy/widget/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../network/oauth_service.dart';
import '../../../utils/theme_files/app_colors.dart';
import 'models/income_dropdown_item.dart';

class FinancialInfo extends StatelessWidget {
  bool isReadOnly;
  FinancialInfo({Key? key, this.isReadOnly = false}) : super(key: key);

  final financialInfoForm = getIt<FormService>().financialInfo;
  List<String> listitems = [
    "Doctorate",
    "Graduate",
    "HIGH SCHOOL",
    "Illiterate",
    "Others",
    "Post Graduate",
    "PROFESSIONAL",
    "Professional Degree",
    "Under High School"
  ];
  String selectval = "Education Qualification";

  @override
  Widget build(BuildContext context) {
    return DiyForm(
      title: 'Financial Information',
      subtitle: 'Your details are safe & secure',
      formGroup: financialInfoForm,
      child: Column(
        children: [
          Container(
            height: 55.sp,
            decoration: BoxDecoration(
                color: AppColors.textFieldBackground(context),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ReactiveDropdownField<int>(
                  dropdownColor: AppColors.textFieldBackground(context),
                  formControlName: 'EducationQualification',
                  items: const [
                    DropdownMenuItem(
                      value: 1,
                      child: Text("Doctorate"),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text("Graduate"),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text("HIGH SCHOOL"),
                    ),
                    DropdownMenuItem(
                      value: 4,
                      child: Text("Illiterate"),
                    ),
                    DropdownMenuItem(
                      value: 5,
                      child: Text("Others"),
                    ),
                    DropdownMenuItem(
                      value: 6,
                      child: Text("Post Graduate"),
                    ),
                    DropdownMenuItem(
                      value: 7,
                      child: Text("PROFESSIONAL"),
                    ),
                    DropdownMenuItem(
                      value: 8,
                      child: Text("Professional Degree"),
                    ),
                    DropdownMenuItem(
                      value: 9,
                      child: Text("Under High School"),
                    ),
                  ],
                  style: TextStyle(
                    color: AppColors.textColorTextField(context),
                  ),
                  hint: Text('Education Qualification',
                      style: TextStyle(
                        color: AppColors.textColorTextField(context),
                      )),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    // filled: AppColors.textFieldBackground(context) != null,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  showErrors: (control) => control.invalid && control.dirty,
                  validationMessages: {
                    'required': (error) =>
                        'Please Select Education Qualification',
                  },
                  iconSize: 30,
                  iconEnabledColor: AppColors.primaryColor(context),
                  iconDisabledColor: AppColors.primaryContent(context),
                ),
              ),
            ),
          ),
          WidgetHelper.verticalSpace20,
          Container(
            height: 55.sp,
            decoration: BoxDecoration(
                color: AppColors.textFieldBackground(context),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: FutureBuilder<List<AnnualIncomeDropdownItem>>(
                future: getIt<ApiRepository>().getIncome(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<AnnualIncomeDropdownItem>> snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: ReactiveDropdownField(
                        dropdownColor: AppColors.textFieldBackground(context),
                        icon: Icon(Icons.arrow_drop_down),
                        items: snapshot.data!
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.AnnualIncomeName,
                                  style: TextStyle(
                                    color: AppColors.textColorTextField(
                                      context,
                                    ),
                                  ),
                                )))
                            .toList(),
                        formControlName: 'AnnualIncome',
                        style: TextStyle(
                          color: AppColors.textColorTextField(context),
                        ),
                        hint: Text('Annual Income',
                            style: TextStyle(
                              color: AppColors.textColorTextField(context),
                            )),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // filled: AppColors.textFieldBackground(context) != null,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        showErrors: (control) =>
                            control.invalid && control.dirty,
                        validationMessages: {
                          'required': (error) => 'Please Select State',
                        },
                        iconSize: 30,
                        iconEnabledColor: AppColors.primaryColor(context),
                        iconDisabledColor: AppColors.primaryContent(context),
                      ),
                    );
                  }
                  return Container(
                    height: 55.sp,
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        color: AppColors.textFieldBackground(context),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownMenuItem(
                      child: Text(
                        'Annual Income',
                        style: TextStyle(
                          color: AppColors.textColorTextField(
                            context,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          WidgetHelper.verticalSpace20,
          Container(
            height: 55.sp,
            decoration: BoxDecoration(
                color: AppColors.textFieldBackground(context),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: FutureBuilder<List<OccupationDropdownItem>>(
                future: getIt<ApiRepository>().getOccupation(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<OccupationDropdownItem>> snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: ReactiveDropdownField(
                        dropdownColor: AppColors.textFieldBackground(context),
                        icon: Icon(Icons.arrow_drop_down),
                        items: snapshot.data!
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.OccupationName,
                                  style: TextStyle(
                                    color: AppColors.textColorTextField(
                                      context,
                                    ),
                                  ),
                                )))
                            .toList(),
                        formControlName: 'Occupation',
                        style: TextStyle(
                          color: AppColors.textColorTextField(context),
                        ),
                        hint: Text('Occupation',
                            style: TextStyle(
                              color: AppColors.textColorTextField(context),
                            )),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // filled: AppColors.textFieldBackground(context) != null,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        showErrors: (control) =>
                            control.invalid && control.dirty,
                        validationMessages: {
                          'required': (error) => 'Please Select Occupation',
                        },
                        iconSize: 30,
                        iconEnabledColor: AppColors.primaryColor(context),
                        iconDisabledColor: AppColors.primaryContent(context),
                      ),
                    );
                  }
                  return Container(
                    height: 55.sp,
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        color: AppColors.textFieldBackground(context),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownMenuItem(
                      child: Text(
                        'Occupation',
                        style: TextStyle(
                          color: AppColors.textColorTextField(
                            context,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          WidgetHelper.verticalSpace20,
          Container(
            height: 55.sp,
            decoration: BoxDecoration(
                color: AppColors.textFieldBackground(context),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: FutureBuilder<List<TradingExperienceDropdownItem>>(
                future: getIt<ApiRepository>().getTradingExperience(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<TradingExperienceDropdownItem>>
                        snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: ReactiveDropdownField(
                        dropdownColor: AppColors.textFieldBackground(context),
                        icon: Icon(Icons.arrow_drop_down),
                        items: snapshot.data!
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.TradingExperienceName,
                                  style: TextStyle(
                                    color: AppColors.textColorTextField(
                                      context,
                                    ),
                                  ),
                                )))
                            .toList(),
                        formControlName: 'TradingExperience',
                        style: TextStyle(
                          color: AppColors.textColorTextField(context),
                        ),
                        hint: Text('Trading Experience',
                            style: TextStyle(
                              color: AppColors.textColorTextField(context),
                            )),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        showErrors: (control) =>
                            control.invalid && control.dirty,
                        validationMessages: {
                          'required': (error) => 'Please Select State',
                        },
                        iconSize: 30,
                        iconEnabledColor: AppColors.primaryColor(context),
                        iconDisabledColor: AppColors.primaryContent(context),
                      ),
                    );
                  }
                  return Container(
                    height: 55.sp,
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        color: AppColors.textFieldBackground(context),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownMenuItem(
                      child: Text(
                        'Trading Experience',
                        style: TextStyle(
                          color: AppColors.textColorTextField(
                            context,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          WidgetHelper.verticalSpace20,
          ReactiveCheckboxListTile(
            activeColor: AppColors.primaryColor(context),
            formControlName: 'Citizen',
            checkboxShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            title: Text(
              'I am Indian citizen, born and residing in India',
              style: TextStyle(
                color: AppColors.primaryContent(context),
                fontSize: 14.sp,
              ),
            ),
          ),
          ReactiveCheckboxListTile(
            activeColor: AppColors.primaryColor(context),
            formControlName: 'PoliticalIdentity',
            checkboxShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            title: Text(
              'I am not a politically exposed person',
              style: TextStyle(
                color: AppColors.primaryContent(context),
                fontSize: 14.sp,
              ),
            ),
          ),
          NextButton(
            text: "Continue",
            onPressed: () async {
              return await getIt<OAuthService>()
                  .sendOtp(
                financialInfoForm.control('phone').value,
              )
                  .then(
                (res) {
                  if (res.status) {
                    AppUtil.showToast(
                      'OTP sent successfully',
                    );
                    return true;
                  } else {
                    AppUtil.showErrorToast(res.arguments);
                  }
                  return false;
                },
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
