import 'package:diy/network/oauth_service.dart';
import 'package:diy/utils/theme_files/app_colors.dart';
import 'package:diy/widget/diy_form.dart';
import 'package:diy/widget/next_button.dart';
import 'package:diy/widget/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../diy.dart';
import '../../network/api_repository.dart';
import '../form_service.dart';
import '../verify-mobile/models/relation_dropdown.dart';

class EmailPage extends StatelessWidget {
  final bool isReadOnly;
  EmailPage({Key? key, this.isReadOnly = false}) : super(key: key);

  final emailForm = getIt<FormService>().emailForm;

  @override
  Widget build(BuildContext context) {
    if (!isReadOnly) {
      emailForm.reset();
    }
    return DiyForm(
      title: "Enter Your Email ID",
      formGroup: emailForm,
      child: Column(
        children: [
          ReactiveValueListenableBuilder(
              formControlName: "googleToggle",
              builder: (context, form, child) {
                if (form.value == false) {
                  return Column(
                    children: [
                      SignInButton(
                        Buttons.Google,
                        onPressed: () {
                          emailForm.control("googleToggle").value = false;
                          //TODO signup with google
                        },
                        padding: const EdgeInsets.all(10),
                      ),
                      WidgetHelper.verticalSpace,
                      ElevatedButton.icon(
                        onPressed: () {
                          emailForm.control("googleToggle").value = true;
                          emailForm.markAsTouched();
                        },
                        icon: const Icon(Icons.email_outlined),
                        label: const Text("Enter Email ID"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.primaryContent(context),
                          primary: AppColors.background(context),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minimumSize: const Size(200, 50),
                        ),
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    ReactiveTextField(
                      readOnly: isReadOnly,
                      formControlName: 'email',
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email ID',
                        hintText: 'Your Email ID',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      showErrors: (control) =>
                          control.invalid && control.hasFocus,
                      validationMessages: {
                        'required': (error) => 'The Email ID must not be empty',
                        'email': (error) =>
                            'The Email ID must be a valid email',
                      },
                    ),
                    WidgetHelper.verticalSpace20,
                    NextButton(
                      text: "Validate E-Mail",
                      onPressed: () async {
                        final res = await getIt<OAuthService>().sendEmailOtp(
                            email: emailForm.control("email").value,
                            relationId: emailForm.control("relation").value);
                        if (res.status) {
                          await getIt<OAuthService>().updateUiStatus().then(
                                (route) => Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  route,
                                  (route) => false,
                                ),
                              );
                          return true;
                        }
                        return false;
                      },
                    ),
                    ReactiveCheckboxListTile(
                      formControlName: 'TnC',
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'I hereby declare that the mobile number belongs to ',
                              style: TextStyle(
                                color: AppColors.primaryContent(context),
                                fontSize: 14.sp,
                              ),
                            ),
                            WidgetSpan(
                              child: FutureBuilder(
                                future: getIt<ApiRepository>()
                                    .getRelationDropDown(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return ReactiveDropdownField(
                                      readOnly: isReadOnly,
                                      hint: const Text('Select Relation'),
                                      items: [
                                        for (RelationDropdown item
                                            in snapshot.data)
                                          DropdownMenuItem(
                                            value: item.RelationId,
                                            child: Text(
                                              item.RelationName,
                                              style: TextStyle(
                                                color: AppColors.primaryContent(
                                                    context),
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          )
                                      ],
                                      formControlName: 'relation',
                                      elevation: 0,
                                      dropdownColor:
                                          AppColors.background(context),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      validationMessages: {
                                        'required': (error) =>
                                            'Please Select a Relation',
                                      },
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
