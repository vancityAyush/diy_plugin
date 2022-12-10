import 'package:diy/network/oauth_service.dart';
import 'package:diy/utils/theme_files/app_colors.dart';
import 'package:diy/widget/diy_form.dart';
import 'package:diy/widget/next_button.dart';
import 'package:diy/widget/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
      title: "Enter Email Address",
      subtitle: "You will receive an OTP on your email",
      formGroup: emailForm,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ReactiveValueListenableBuilder(
              formControlName: "googleToggle",
              builder: (context, form, child) {
                if (form.value == false) {
                  return Column(
                    children: [
                      // SignInButton(
                      //   elevation: 0,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(5)),
                      //   Buttons.Google,
                      //   onPressed: () {
                      //     emailForm.control("googleToggle").value = false;
                      //     //TODO signup with google
                      //   },
                      //   padding: const EdgeInsets.all(10),
                      //   text: "Continue with Google",
                      // ),
                      // WidgetHelper.verticalSpace,
                      WidgetHelper.verticalSpace,
                      ElevatedButton.icon(
                        onPressed: () {
                          emailForm.control("googleToggle").value = false;
                          //TODO signup with google
                        },
                        icon: SvgPicture.asset(
                          "packages/diy/assets/google.svg",
                          width: 30,
                        ),
                        label: const Text("Continue with Google"),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor:
                              AppColors.textFieldBackground(context),
                          foregroundColor: AppColors.primaryContent(context),
                          primary: AppColors.background(context),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minimumSize: const Size(400, 60),
                        ),
                      ),
                      WidgetHelper.verticalSpace,
                      Text(
                        "OR",
                        style: TextStyle(
                          color: AppColors.subHeading(context),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      WidgetHelper.verticalSpace,
                      ElevatedButton.icon(
                        onPressed: () {
                          emailForm.control("googleToggle").value = true;
                          emailForm.markAsTouched();
                        },
                        icon: SvgPicture.asset(
                          "packages/diy/assets/email.svg",
                          width: 30,
                          color: AppColors.primaryContent(context),
                        ),
                        label: const Text("Enter Email ID"),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor:
                              AppColors.textFieldBackground(context),
                          foregroundColor: AppColors.primaryContent(context),
                          primary: AppColors.background(context),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minimumSize: const Size(400, 60),
                        ),
                      ),
                    ],
                  );
                }
                return SizedBox(
                  height:
                      WidgetsBinding.instance.window.physicalSize.height / 4.5,
                  child: Column(
                    children: [
                      ReactiveTextField(
                        readOnly: isReadOnly,
                        formControlName: 'email',
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: AppColors.primaryColor(context),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 20.0),
                          filled:
                              AppColors.textFieldBackground(context) != null,
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
                          // labelText: 'Email ID',
                          // labelStyle:
                          //     TextStyle(color: AppColors.primaryContent(context)),
                          hintText: 'Your Email ID',
                          hintStyle: TextStyle(
                              color: AppColors.textColorTextField(context)),
                          // prefixIcon: Icon(
                          //   Icons.email_outlined,
                          //   color: Theme.of(context).primaryColor,
                          // ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        showErrors: (control) =>
                            control.invalid && control.hasFocus,
                        validationMessages: {
                          'required': (error) =>
                              'The Email ID must not be empty',
                          'email': (error) =>
                              'The Email ID must be a valid email',
                        },
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 4,
                            child: Column(
                              children: [
                                NextButton(
                                  text: "Validate E-Mail",
                                  onPressed: () async {
                                    final res = await getIt<OAuthService>()
                                        .sendEmailOtp(
                                            email: emailForm
                                                .control("email")
                                                .value,
                                            relationId: emailForm
                                                .control("relation")
                                                .value);
                                    if (res.status) {
                                      await getIt<OAuthService>()
                                          .updateUiStatus()
                                          .then(
                                            (route) => Navigator
                                                .pushNamedAndRemoveUntil(
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
                                Row(
                                  children: [
                                    ReactiveCheckbox(
                                      activeColor:
                                          AppColors.primaryColor(context),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      formControlName: 'TnC',
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          text:
                                              'I hereby declare that the mobile number belongs to ',
                                          style: TextStyle(
                                            color: AppColors.primaryContent(
                                                context),
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: FutureBuilder(
                                          future: getIt<ApiRepository>()
                                              .getRelationDropDown(),
                                          builder: (context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.hasData) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 50),
                                                child: ReactiveDropdownField(
                                                  formControlName: 'relation',
                                                  hint: Text('Select Relation',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .primaryColor(
                                                                  context),
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                  iconSize: 30,
                                                  iconEnabledColor:
                                                      AppColors.primaryColor(
                                                          context),
                                                  iconDisabledColor:
                                                      AppColors.primaryContent(
                                                          context),
                                                  items: [
                                                    for (RelationDropdown item
                                                        in snapshot.data)
                                                      DropdownMenuItem(
                                                        value: item.RelationId,
                                                        child: Text(
                                                          item.RelationName,
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .primaryContent(
                                                                    context),
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                      )
                                                  ],
                                                  elevation: 0,
                                                  dropdownColor:
                                                      AppColors.background(
                                                          context),
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                  validationMessages: {
                                                    'required': (error) =>
                                                        'Please Select a Relation',
                                                  },
                                                ),
                                              );
                                            }
                                            return Container();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // ReactiveCheckboxListTile(
                      //   activeColor: AppColors.primaryColor(context),
                      //   formControlName: 'TnC',
                      //   checkboxShape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(4),
                      //   ),
                      //   title: RichText(
                      //     text: TextSpan(
                      //       children: [
                      //         TextSpan(
                      //           text: 'I hereby declare that the mobile number',
                      //           style: TextStyle(
                      //             color: AppColors.primaryContent(context),
                      //             fontSize: 14.sp,
                      //           ),
                      //         ),
                      //         WidgetSpan(
                      //           child: FutureBuilder(
                      //             future: getIt<ApiRepository>()
                      //                 .getRelationDropDown(),
                      //             builder: (context, AsyncSnapshot snapshot) {
                      //               if (snapshot.hasData) {
                      //                 return ReactiveDropdownField(
                      //                   readOnly: isReadOnly,
                      //                   hint: const Text('Select Relation'),
                      //                   items: [
                      //                     for (RelationDropdown item
                      //                         in snapshot.data)
                      //                       DropdownMenuItem(
                      //                         value: item.RelationId,
                      //                         child: Text(
                      //                           item.RelationName,
                      //                           style: TextStyle(
                      //                             color: AppColors.primaryContent(
                      //                                 context),
                      //                             fontSize: 14.sp,
                      //                           ),
                      //                         ),
                      //                       )
                      //                   ],
                      //                   formControlName: 'relation',
                      //                   elevation: 0,
                      //                   dropdownColor:
                      //                       AppColors.background(context),
                      //                   decoration: const InputDecoration(
                      //                     border: InputBorder.none,
                      //                   ),
                      //                   validationMessages: {
                      //                     'required': (error) =>
                      //                         'Please Select a Relation',
                      //                   },
                      //                 );
                      //               }
                      //               return Container();
                      //             },
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
