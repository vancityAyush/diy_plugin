import 'package:diy/diy.dart';
import 'package:diy/modules/verify-mobile/models/relation_dropdown.dart';
import 'package:diy/network/http_client.dart';
import 'package:diy/network/oauth_service.dart';
import 'package:intl/intl.dart';

import '../utils/util.dart';

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
    try {
      final res = await http.post(
        "/app/send-email-otp/",
        data: {
          "Email": email,
          "EmailRelationshipId": relationId,
        },
      );
      return res;
    } on HttpException catch (e) {
      AppUtil.showErrorToast(e.error["ErrorMessage"]);
      print(e);
    } catch (e) {
      print(e);
    }
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

  Future<dynamic> validatePan(
      {required String pan,
      required DateTime dob,
      bool kraVerified = true,
      bool panVerified = true,
      String? firstName,
      String? middleName,
      String? lastName,
      String? uan}) async {
    final res = await http.postEncrypted(
      "/app/validate-pan/",
      data: {
        "PAN": pan,
        "DateOfBirth": DateFormat("yyyy-MM-dd").format(dob) + "T00:00:00",
        "KraVerified": kraVerified,
        "PanVerified": panVerified,
        "FirstName": firstName,
        "MiddleName": middleName,
        "LastName": lastName,
        "UAN": uan
      },
    );
    return res;
  }

  Future<dynamic> validateKra(
      String pan,
      String dob,
      bool kraVerified,
      bool panVerified,
      String firstName,
      String middleName,
      String lastName,
      Null uan) async {
    final res = await http.postEncrypted(
      "/app/validate-kra/",
      data: {
        "PAN": pan,
        "DateOfBirth": dob,
        "KraVerified": kraVerified,
        "PanVerified": panVerified,
        "FirstName": firstName,
        "MiddleName": middleName,
        "LastName": lastName,
        "UAN": uan
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
