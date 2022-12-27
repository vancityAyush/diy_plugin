import 'package:diy/utils/libs.dart';
import 'package:diy/utils/util.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:reactive_image_picker/image_file.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';

class UploadSelfie extends StatefulWidget {
  bool isReadOnly;
  UploadSelfie({Key? key, this.isReadOnly = false}) : super(key: key);

  @override
  State<UploadSelfie> createState() => _UploadSelfieState();
}

class _UploadSelfieState extends State<UploadSelfie> {
  final uploadSelfie = getIt<FormService>().uploadSelfie;

  final Location location = new Location();
  late LocationData _locationData;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  @override
  void initState() {
    initLocation();
    super.initState();
  }

  initLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return DiyForm(
      formGroup: uploadSelfie,
      title: "Upload Selfie",
      //subtitle: "Aadhaar Proof(front side)",
      child: Column(
        children: [
          WidgetHelper.verticalSpace20,
          if (!widget.isReadOnly)
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
              image: getIt<ApiRepository>().getImage(DOCTYPE.Selfie),
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
          if (widget.isReadOnly)
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
          if (!widget.isReadOnly)
            Align(
              alignment: Alignment.bottomCenter,
              child: NextButton(
                text: "Next",
                validateForm: false,
                onPressed: () async {
                  final permission = await location.hasPermission();
                  if (permission != PermissionStatus.granted) {
                    await location.requestPermission();
                  }
                  if (permission == PermissionStatus.granted) {
                    _locationData = await location.getLocation();
                    ImageFile imageFile =
                        uploadSelfie.control('UploadSelfie').value;
                    if (imageFile != null) {
                      final res = await getIt<ApiRepository>().uploadImage(
                        file: imageFile.image!,
                        type: DOCTYPE.Selfie,
                        lat: _locationData.latitude ?? 0,
                        long: _locationData.longitude ?? 0,
                      );
                      await getIt<OAuthService>().updateUiStatus().then(
                            (route) => Navigator.pushNamedAndRemoveUntil(
                              context,
                              route,
                              (route) => false,
                            ),
                          );
                      return true;
                    }
                  }
                  return false;
                },
              ),
            ),
        ],
      ),
    );
  }
}
