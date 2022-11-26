library diy;

import 'package:diy/modules/form_service.dart';
import 'package:diy/network/http_client.dart';
import 'package:diy/utils/theme_files/app_colors.dart';
import 'package:diy/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'modules/form-email/email_page.dart';
import 'modules/ifsc/ui/ifsc_page.dart';
import 'modules/pan/ui/enter_pan.dart';
import 'modules/pan/ui/validate_kra.dart';
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
    getIt.registerSingleton(FormService());
    isInit = true;
  }

  Future<dynamic> init(BuildContext context) async {
    await ScreenUtil.ensureScreenSize();
    ScreenUtil.init(context);
    await getIt<OAuthService>().initState();
    String route = await getIt<OAuthService>().updateUiStatus();
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
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          child: Navigator(
            initialRoute: "/",
            onGenerateRoute: (settings) {
              final arguments = settings.arguments != null
                  ? settings.arguments as Map<String, dynamic>
                  : {};
              bool isReadOnly = arguments[kReadOnly] ?? false;
              Widget page;
              switch (settings.name) {
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
