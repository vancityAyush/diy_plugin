import 'dart:convert';

import 'package:diy/utils/libs.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:reactive_image_picker/image_file.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';

class UploadBankProof extends StatelessWidget {
  bool isReadOnly;
  UploadBankProof({Key? key, this.isReadOnly = false}) : super(key: key);

  final uploadBankProofForm = getIt<FormService>().uploadBankProofForm;

  @override
  Widget build(BuildContext context) {
    return DiyForm(
      formGroup: uploadBankProofForm,
      title: "Upload Bank Proof",
      subtitle:
          "Your bank account details could not be verified. Please proceed by uploading: cancelled cheque OR passbook photo",
      child: Column(
        children: [
          ReactiveImagePicker(
            formControlName: 'BankProof',
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
                    color: AppColors.background(context),
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
          NextButton(
            text: "Next",
            onPressed: () async {
              ImageFile imageFile =
                  uploadBankProofForm.control('BankProof').value;
              List<int> bytes = imageFile.image!.readAsBytesSync();
              String base64Image = base64Encode(bytes);
              print(base64Image);
              return true;
            },
          )
        ],
      ),
    );
  }
}
