import 'package:diy/utils/libs.dart';
import 'package:diy/utils/util.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:reactive_image_picker/image_file.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';

//TODO Merge both screens as one
class AddressProofBack extends StatefulWidget {
  bool isReadOnly;
  AddressProofBack({Key? key, this.isReadOnly = false}) : super(key: key);

  @override
  State<AddressProofBack> createState() => _AddressProofBackState();
}

class _AddressProofBackState extends State<AddressProofBack> {
  final uploadAddressProofBack = getIt<FormService>().uploadAddressProof;

  @override
  Widget build(BuildContext context) {
    return DiyForm(
      formGroup: uploadAddressProofBack,
      title: "Upload Address Proof",
      subtitle: "Address Proof(back side)",
      child: SizedBox(
        height: WidgetsBinding.instance.window.physicalSize.height / 5,
        child: Column(
          children: [
            WidgetHelper.verticalSpace20,
            if (!widget.isReadOnly)
              ReactiveImagePicker(
                formControlName: 'AddressProofBack',
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
              ),
            if (widget.isReadOnly)
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
                    .getImage(DOCTYPE.AddressProofBackSide),
                width: double.infinity,
                height: 250.sp,
                fit: BoxFit.contain,
              ),
            WidgetHelper.verticalSpace20,
            if (widget.isReadOnly)
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.isReadOnly = false;
                    });
                  },
                  child: const Text("Recapture")),
            if (!widget.isReadOnly)
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: NextButton(
                    text: "Next",
                    validateForm: false,
                    onPressed: () async {
                      ImageFile imageFile = uploadAddressProofBack
                          .control('AddressProofBack')
                          .value;
                      if (imageFile != null) {
                        final res = await getIt<ApiRepository>().uploadImage(
                            file: imageFile.image!,
                            type: DOCTYPE.AddressProofBackSide);
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
}
