import 'package:dio/dio.dart';
import 'package:diy/diy.dart';
import 'package:diy/network/oauth_service.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final OAuthService oauthService = getIt<OAuthService>();
    if (!options.path.contains("/auth")) {
      if (oauthService.token.isExpired) {
        await oauthService.refreshToken();
      }
      options.headers.addAll(
        {
          'Authorization': oauthService.token.toString(),
        },
      );
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response!.statusCode == 401) {
      // getIt<OAuthService>().signOut();
    }

    return super.onError(err, handler);
  }
}
