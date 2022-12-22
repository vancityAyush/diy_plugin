import 'package:diy/utils/libs.dart';
import 'package:diy/utils/util.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:reactive_image_picker/image_file.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';

class UploadSelfie extends StatelessWidget {
  bool isReadOnly;
  UploadSelfie({Key? key, this.isReadOnly = false}) : super(key: key);
  final uploadSelfie = getIt<FormService>().uploadSelfie;
  @override
  Widget build(BuildContext context) {
    return DiyForm(
      formGroup: uploadSelfie,
      title: "Upload Selfie",
      //subtitle: "Aadhaar Proof(front side)",
      child: Column(
        children: [
          WidgetHelper.verticalSpace20,
          if (!isReadOnly)
            ReactiveImagePicker(
              formControlName: 'UploadSelfie',
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
              image: getIt<ApiRepository>().getImage(DOCTYPE.Selfie),
              width: double.infinity,
              height: 250.sp,
              fit: BoxFit.contain,
            ),
          WidgetHelper.verticalSpace20,
          if (!isReadOnly)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.primaryColor(context),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
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
          if (isReadOnly!)
            Align(
              alignment: Alignment.bottomCenter,
              child: NextButton(
                text: "Next",
                validateForm: false,
                onPressed: () async {
                  ImageFile imageFile =
                      uploadSelfie.control('UploadSelfie').value;
                  if (imageFile != null) {
                    final res = await getIt<ApiRepository>().uploadImage(
                        file: imageFile.image!, type: DOCTYPE.Signature);
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
        ],
      ),
    );
  }
  //),
  //);
}
