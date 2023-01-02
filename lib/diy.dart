library diy;

import 'package:diy/modules/addressproof/address-proof-back-side.dart';
import 'package:diy/modules/bank_proof/upload_bank_proof.dart';
import 'package:diy/modules/esign/esign.dart';
import 'package:diy/modules/financial-info/financial-info.dart';
import 'package:diy/modules/form_service.dart';
import 'package:diy/modules/invest-now/invest-now.dart';
import 'package:diy/modules/ipv/ipv-start.dart';
import 'package:diy/modules/ipv/ipv-upload.dart';
import 'package:diy/modules/kyc/kyc-select.dart';
import 'package:diy/modules/personal-details/personal-details.dart';
import 'package:diy/modules/upload-pan-photo/upload-pan-photo.dart';
import 'package:diy/modules/upload-signature/upload-signature.dart';
import 'package:diy/network/http_client.dart';
import 'package:diy/utils/constants.dart';
import 'package:diy/utils/theme_files/app_colors.dart';
import 'package:diy/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';

import 'modules/addressproof/address-proof-front-side.dart';
import 'modules/bank/bank_account.dart';
import 'modules/correspondence_address/correspondence_address.dart';
import 'modules/derivativeproof/derivative-proof.dart';
import 'modules/form-email/email_page.dart';
import 'modules/ifsc/ui/ifsc_page.dart';
import 'modules/nomination/esign.dart';
import 'modules/pan/enter_pan.dart';
import 'modules/pan/validate_kra.dart';
import 'modules/select-plan/select-plan.dart';
import 'modules/upload-selfie/upload-selfie.dart';
import 'modules/verify-email/verify_email.dart';
import 'modules/verify-mobile/ui/signup_page.dart';
import 'network/api_repository.dart';
import 'network/oauth_service.dart';

GetIt getIt = GetIt.instance;

class FlutterDIY {
  bool isInit = false;

  FlutterDIY() {
    WidgetsFlutterBinding.ensureInitialized();
    getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
    final httpClient = HttpClient(baseUrl);
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
    getIt.registerSingleton(FormService());
    isInit = true;
  }

  requestPermissions() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      await Permission.camera.request();
    }
  }

  Future<dynamic> init(BuildContext context) async {
    await requestPermissions();
    await ScreenUtil.ensureScreenSize();
    ScreenUtil.init(context);
    await getIt<OAuthService>().initState();
    // String route = await getIt<OAuthService>().updateUiStatus();
    return showMaterialModalBottomSheet(
      backgroundColor: AppColors.background(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      enableDrag: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      isDismissible: false,
      useRootNavigator: true,
      context: (context),
      builder: (context) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.70,
          ),
          child: Navigator(
            initialRoute: "/",
            onGenerateRoute: (settings) {
              final arguments = settings.arguments != null
                  ? settings.arguments as Map<String, dynamic>
                  : {};
              bool isReadOnly = arguments[kReadOnly] ?? false;
              //TODO REMOVE BELOW LINE
              // isReadOnly = false;
              Widget page;
              if (settings.name == "/logout") {
                Navigator.pop(context);
              }
              switch (settings.name) {
                case '/form/nomination':
                  page = Nomination(isReadOnly: isReadOnly);
                  break;
                case '/form/select-plan':
                  page = SelectPlan(isReadOnly: isReadOnly);
                  break;
                case '/form/invest-now':
                  page = InvestNow(isReadOnly: isReadOnly);
                  break;
                case '/form/esign':
                  page = ESign(isReadOnly: isReadOnly);
                  break;
                case '/form/ipv':
                  if (isReadOnly) {
                    page = UploadIpv(isReadOnly: isReadOnly);
                  } else {
                    page = IpvStart();
                  }
                  break;
                case '/form/upload-selfie':
                  page = UploadSelfie(isReadOnly: isReadOnly);
                  break;
                case '/form/financial-info':
                  page = FinancialInfo(isReadOnly: isReadOnly);
                  break;
                case '/form/personal-details':
                  page = PersonalDetails(isReadOnly: isReadOnly);
                  break;
                case '/form/upload-sign':
                  page = UploadSignature(isReadOnly: isReadOnly);
                  break;
                case '/form/upload-derivative-proof':
                  page = DerivativeProofFront(isReadOnly: isReadOnly);
                  break;
                case '/form/correspondence-address':
                  page = Correspondence_address(isReadOnly: isReadOnly);
                  break;
                case '/form/address-proof-back-side':
                  page = AddressProofBack(isReadOnly: isReadOnly);
                  break;
                case '/form/address-proof-front-side':
                  page = AddressProofFront(isReadOnly: isReadOnly);
                  break;
                case '/form/upload-pan-photo':
                  page = UploadPanPhoto(isReadOnly: isReadOnly);
                  break;
                case '/form/kyc':
                  page = KycSelect();
                  break;
                case '/form/upload-bank-proof':
                  page = UploadBankProof(isReadOnly: isReadOnly);
                  break;
                case '/form/bank-account-no':
                  page = BankAccountNumber(isReadOnly: isReadOnly);
                  break;
                case '/form/bank-ifsc-code':
                  page = IFSCPage(isReadOnly: isReadOnly);
                  break;
                case "/app/validate-kra/":
                  page = ValidateKra(isReadOnly: isReadOnly);
                  break;
                case "/app/validate-pan/":
                  page = EnterPan(
                    isReadOnly: isReadOnly,
                  );
                  break;
                case '/form/verify-email':
                  page = VerifyEmailPage(
                    isReadOnly: isReadOnly,
                  );
                  break;
                case "/form/email":
                  page = EmailPage(
                    isReadOnly: isReadOnly,
                  );
                  break;
                default:
                  page = SignUpPage();
                  break;
              }
              return PageRouteBuilder(
                settings: settings,
                pageBuilder: (context, animation, secondaryAnimation) => page,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
