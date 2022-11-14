import 'package:diy/diy.dart';
import 'package:diy/modules/verify-mobile/models/relation_dropdown.dart';
import 'package:diy/network/http_client.dart';
import 'package:diy/network/oauth_service.dart';

import 'models/Response.dart';

class ApiRepository {
  final http = getIt<HttpClient>();
  final OAuthService oauthService = getIt<OAuthService>();
  dynamic response;

  Future<List<RelationDropdown>> getRelationDropDown() async {
    final res = await http.get("/pre/email-mobile-relationship/");
    return res
        .map<RelationDropdown>((e) => RelationDropdown.fromJson(e))
        .toList();
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

  // Future<dynamic> validatePan(
  //     {required String pan,
  //     required String dob,
  //     required bool kraVerified,
  //     required bool panVerified,
  //     required String firstName,
  //     required String middleName,
  //     required String lastName,
  //     required String uan}) async {
  //   final res = await http.postEncrypted(
  //     "/app/validate-email/",
  //     data: {
  //       "PAN": pan,
  //       "DOB": dob,
  //       "KraVerified": kraVerified,
  //       "panVerified": panVerified,
  //       "FirstName": firstName,
  //       "MiddleName": middleName,
  //       "LastName": lastName,
  //       "UAN": uan
  //     },
  //   );
  //   return res;
  // }

  Future<dynamic> validatePan(
      {required String pan, required String dob}) async {
    final res = await http.postEncrypted(
      "/app/validate-pan/",
      data: {
        "PAN": pan,
        "DateOfBirth": dob,
      },
    );
  }

  Future<dynamic> validateKra(
      String pan,
      String dob,
      bool kraVerified,
      bool panVerified,
      String firstName,
      String middleName,
      String lastName,
      String ua) async {
    final res = await http.postEncrypted(
      "/app/validate-kra/",
      data: {
        "PAN": pan,
        "DOB": dob,
        "KraVerified": kraVerified,
        "PanVerified": panVerified,
        "FirstName": firstName,
        "MiddleName": middleName,
        "LastName": lastName,
        "UAN": ua
      },
    );
    return res;
  }

  // Future<ResponseModel> panDetails(
  //   {  required String pan,
  //     required String dob,
  //     bool kraVerified = false,
  //     bool panVerified =false,
  //     String firstName,
  //     String middleName,
  //     String lastName,
  //     String uan}) async {
  //   try {
  //     response = await validatePan(pan, dob, kraVerified, panVerified,
  //         firstName, middleName, lastName, uan);
  //     if (response != null) {
  //       return ResponseModel(
  //         success: true,
  //         message: "OTP sent successfully",
  //       );
  //     } else {
  //       return ResponseModel(success: false, message: "Error sending OTP");
  //     }
  //   } catch (e) {
  //     print(e);
  //     return ResponseModel(success: false, message: e);
  //   }
  // }
}
