import 'package:diy/diy.dart';
import 'package:diy/modules/verify-mobile/models/relation_dropdown.dart';
import 'package:diy/network/http_client.dart';
import 'package:diy/network/oauth_service.dart';
import 'package:intl/intl.dart';

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
