import 'package:diy/modules/derivativeproof/model/income_dropdown_item.dart';
import 'package:diy/utils/libs.dart';
import 'package:diy/utils/util.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:reactive_image_picker/image_file.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';

class DerivativeProofFront extends StatelessWidget {
  bool isReadOnly;
  DerivativeProofFront({Key? key, this.isReadOnly = false}) : super(key: key);
  final uploadDerivativeProof = getIt<FormService>().uploadDerivativeProof;
  @override
  Widget build(BuildContext context) {
    return DiyForm(
      formGroup: uploadDerivativeProof,
      title: "Derivative Proof",
      //subtitle: "Aadhaar Proof(front side)",
      child: SizedBox(
        height: WidgetsBinding.instance.window.physicalSize.height / 5,
        child: Column(
          children: [
            Container(
              height: 55.sp,
              decoration: BoxDecoration(
                  color: AppColors.textFieldBackground(context),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: FutureBuilder<List<IncomeProofDropdownItem>>(
                  future: getIt<ApiRepository>().getIncomeProof(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<IncomeProofDropdownItem>> snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: ReactiveDropdownField(
                          dropdownColor: AppColors.background(context),
                          icon: Icon(Icons.arrow_drop_down),
                          items: snapshot.data!
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e.DocumentName,
                                    style: TextStyle(
                                      color: AppColors.textColorTextField(
                                        context,
                                      ),
                                    ),
                                  )))
                              .toList(),
                          formControlName: 'IncomeProof',
                          style: TextStyle(
                            color: AppColors.textColorTextField(context),
                          ),
                          hint: Text('Income Proof Type',
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
                          'Income Proof Type',
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
            if (!isReadOnly)
              ReactiveImagePicker(
                formControlName: 'DerivativeProof',
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    labelText: 'Drop your document image here',
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    helperText: ''),
                validationMessages: {
                  ValidationMessage.required: (a) =>
                      'Please upload your document image',
                },
                inputBuilder: (onPressed) => DottedBorder(
                  color:
                      AppColors.footerText(context), //color of dotted/dash line
                  strokeWidth: 1, //thickness of dash/dots
                  dashPattern: [4, 4],
                  child: InkWell(
                    onTap: onPressed,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.textFieldBackground(context),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Icon(
                              Icons.cloud_upload_outlined,
                              color: AppColors.primaryColor(context),
                              size: 50,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Drop your document image here',
                              style: TextStyle(
                                color: AppColors.primaryContent(context),
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Supported: JPG, JPEG or PNG less than 10MB',
                              style: TextStyle(
                                color: AppColors.primaryContent(context),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                //     TextButton.icon(
                //   onPressed: onPressed,
                //   icon: Icon(
                //     Icons.image,
                //     color: AppColors.primaryColor(context),
                //   ),
                //   label: Text(
                //     'Drop your document image hereProofs supported: Photo of your cancelled cheque / Photo of your passbook',
                //     style: TextStyle(
                //         color: AppColors.primaryContent(context),
                //         fontSize: 14.sp),
                //   ),
                // ),
              ),
            if (isReadOnly)
              Image(
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor(context),
                    ),
                  );
                },
                image: getIt<ApiRepository>()
                    .getImage(DOCTYPE.AddressProofFrontSide),
                width: double.infinity,
                height: 250.sp,
                fit: BoxFit.contain,
              ),
            WidgetHelper.verticalSpace20,
            if (!isReadOnly)
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryColor(context),
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          textStyle: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/form/address-proof-back-side',
                          (route) => false,
                        );
                      },
                      child: Row(
                        children: const [
                          const Spacer(),
                          Text(
                            'Continue',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            if (isReadOnly!)
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: NextButton(
                    text: "Next",
                    validateForm: false,
                    onPressed: () async {
                      ImageFile imageFile = uploadDerivativeProof
                          .control('DerivativeProof')
                          .value;
                      if (imageFile != null) {
                        final res = await getIt<ApiRepository>().uploadImage(
                            file: imageFile.image!, type: DOCTYPE.IncomeProo);
                        print(res);
                        final res3 =
                            await getIt<OAuthService>().updateUiStatus().then(
                                  (route) => Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    route,
                                    (route) => false,
                                  ),
                                );
                        print(res3);
                        return true;
                      }
                      return false;
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  //),
  //);
}
