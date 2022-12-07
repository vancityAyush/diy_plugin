import 'package:diy/utils/libs.dart';
import 'package:diy/utils/util.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:reactive_image_picker/image_file.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';

//TODO Merge both screens as one
class AddressProofBack extends StatelessWidget {
  bool isReadOnly;
  AddressProofBack({Key? key, this.isReadOnly = false}) : super(key: key);
  final uploadAddressProofBack = getIt<FormService>().uploadAddressProof;
  @override
  Widget build(BuildContext context) {
    return DiyForm(
      formGroup: uploadAddressProofBack,
      title: "Upload Aadhaar Proof",
      subtitle: "Aadhaar Proof(back side)",
      terms: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: NextButton(
          text: "Next",
          onPressed: () async {
            ImageFile imageFile =
                uploadAddressProofBack.control('AddressProofFront').value;
            if (imageFile != null) {
              final res = await getIt<ApiRepository>().uploadImage(
                  file: imageFile.image!, type: DOCTYPE.AddressProofBackSide);
              print(res);
              final res3 = await getIt<OAuthService>().updateUiStatus().then(
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
      child:
          // FutureBuilder<List<dynamic>>(
          //     future: getIt<ApiRepository>().getBankNames(),
          //     builder: (context, snapshot) {
          //       if (!snapshot.hasData) {
          //         return Center(
          //           child: CircularProgressIndicator(
          //             color: AppColors.primaryColor(context),
          //           ),
          //         );
          //       }
          //       return
          Column(
        children: [
          WidgetHelper.verticalSpace20,
          // ReactiveDropdownField(
          //   formControlName: 'AddressProofFront',
          //   items: snapshot.data!
          //       .map(
          //         (e) => DropdownMenuItem(
          //           value: e,
          //           child: Text(
          //             e,
          //             style: TextStyle(
          //               color: AppColors.primaryContent(
          //                 context,
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          //       .toList(),
          //   style: TextStyle(
          //     color: AppColors.primaryContent(context),
          //   ),
          //   decoration: InputDecoration(
          //     filled: AppColors.textFieldBackground(context) != null,
          //     labelText: 'Bank Name',
          //     labelStyle:
          //         TextStyle(color: AppColors.primaryContent(context)),
          //     hintText: 'Enter Your Bank Name',
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(4),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderSide: BorderSide(
          //         color: AppColors.primaryColor(context),
          //       ),
          //       borderRadius: BorderRadius.circular(4),
          //     ),
          //     prefixIcon: Icon(
          //       Icons.account_balance,
          //       color: AppColors.primaryColor(context),
          //     ),
          //   ),
          //   showErrors: (control) => control.invalid && control.dirty,
          //   validationMessages: {
          //     'required': (error) => 'Please Enter Bank Name',
          //   },
          // ),
          WidgetHelper.verticalSpace20,
          ReactiveImagePicker(
            formControlName: 'AddressProofFront',
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
              color: AppColors.footerText(context), //color of dotted/dash line
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
        ],
      ),
    );
  }
}
