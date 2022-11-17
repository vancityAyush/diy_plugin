library diy;

import 'package:diy/modules/pan/ui/enter_pan.dart';
import 'package:diy/modules/pan/ui/pan_upload_page.dart';
import 'package:diy/modules/verify-email/verify_email.dart';
import 'package:diy/network/http_client.dart';
import 'package:diy/utils/theme_files/app_colors.dart';
import 'package:diy/widget/navigator/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'modules/form-email/email_page.dart';
import 'modules/verify-mobile/ui/otp_page.dart';
import 'modules/verify-mobile/ui/signup.dart';
import 'network/api_repository.dart';
import 'network/oauth_service.dart';
import 'widget/navigator/bottom_modal_navigator.dart';

GetIt getIt = GetIt.instance;

class FlutterDIY {
  bool isInit = false;

  FlutterDIY() {
    WidgetsFlutterBinding.ensureInitialized();
    getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
    final httpClient = HttpClient("https://newdiy.cloudyhr.com/diy/api");
    getIt.registerSingletonAsync<HttpClient>(() async => httpClient);
    getIt.registerSingletonWithDependencies<OAuthService>(
      () => OAuthService(
        httpClient,
        getIt.get<FlutterSecureStorage>(),
      ),
      dependsOn: [HttpClient],
    );
    getIt.registerSingletonWithDependencies<ApiRepository>(
      () => ApiRepository(),
      dependsOn: [OAuthService, HttpClient],
    );
    isInit = true;
  }

  Future<dynamic> init(BuildContext context) async {
    if (!isInit) {
      await Future.delayed(const Duration(seconds: 1), () {});
    }
    await getIt<OAuthService>().initState();
    return showMaterialModalBottomSheet(
      backgroundColor: AppColors.background(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      enableDrag: false,
      isDismissible: false,
      context: (context),
      builder: (context) {
        Get.put(
          BottomSheetNavigator(
            initialRoute: "/",
            routes: {
              "/": SignUpPage(),
              "/otp": const OtpPage(),
              "/form/email": const EmailPage(),
              "/verify-email": const VerifyEmail(),
              "/enter-pan": EnterPAN(),
              "/pan-upload": const PanUploadPage(),
            },
          ),
        );
        return const BottomModalNavigator();
      },
    );
  }
}
