import 'package:diy/diy.dart';
import 'package:diy/network/http_client.dart';
import 'package:diy/network/oauth_service.dart';

class ApiRepository {
  final http = getIt<HttpClient>();
  final OAuthService oauthService = getIt<OAuthService>();

  Future<dynamic> getRelationDropDown() async {
    final res = await http.get("/pre/email-mobile-relationship/");
    return res;
  }

  Future<dynamic> sendEmailOtp(
      {required String email, int relationId = 1}) async {
    final res = await http.post(
      "/app/send-email-otp/",
      data: {
        "Email": email,
        "EmailRelationshipId": relationId,
      },
    );
    return res;
  }

  Future<dynamic> validateEmail(
      {required String email,
      int relationId = 1,
      required String otp,
      required String refId}) async {
    final res = await http.postEncrypted(
      "/app/validate-email/",
      data: {
        "Email": email,
        "EmailRelationshipId": relationId,
        "Otp": otp,
        "RefId": refId
      },
    );
    return res;
  }
}
