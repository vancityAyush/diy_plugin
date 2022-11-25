import 'package:diy/diy.dart';
import 'package:diy/modules/bank/models/bank.dart';
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

  Future<dynamic> validateKra(Map<String, dynamic> data) async {
    final res = await http.postEncrypted(
      "/app/validate-kra/",
      data: data,
      // {
      //   "PAN": pan,
      //   "DateOfBirth": dob,
      //   "KraVerified": kraVerified,
      //   "PanVerified": panVerified,
      //   "FirstName": firstName,
      //   "MiddleName": middleName,
      //   "LastName": lastName,
      //   "UAN": uan
      // },
    );
    return res;
  }

  Future<dynamic> validateBankAcc({
    String? ifsc,
    required String bankaccNo,
    String? bank,
    String? branch,
    String? branchcode,
    String? micrCode,
    String? customerid,
    bool? nameverified,
    bool? skip,
  }) async {
    final res = await http.postEncrypted(
      "/app/validate-bank/",
      data: {
        "IFSC": ifsc,
        "BankAccountNo": bankaccNo,
        "Bank": bank,
        "Branch": branch,
        "BranchCode": branchcode,
        "MICR_CODE": micrCode,
        "CustomerId": customerid,
        "NameVerified": nameverified,
        "Skip": skip,
      },
    );
    return res;
  }

  Future<List<dynamic>> getBankNames() async {
    final res = await http.get("/masters/bank-names/");
    return res;
  }

  Future<List<bank>> getIFSC({
    required String bankName,
    required String location,
  }) async {
    bankName.replaceAll(" ", "%20");
    final res = await http.post(
      "/masters/banks/$bankName",
      data: {
        "Data": location,
      },
    );
    return res;
  }
}
