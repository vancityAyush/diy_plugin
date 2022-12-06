import 'dart:convert';
import 'dart:io';

import 'package:diy/diy.dart';
import 'package:diy/modules/verify-mobile/models/relation_dropdown.dart';
import 'package:diy/network/http_client.dart';
import 'package:diy/network/oauth_service.dart';
import 'package:diy/utils/util.dart';
import 'package:intl/intl.dart';
import 'package:reactive_image_picker/image_file.dart';

import '../modules/ifsc/models/bank.dart';

typedef Request = Map<String, dynamic>;

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

  Future<dynamic> selectIfsc(Map<String, dynamic> data) async {
    final res = await http.post("/app/select-ifsc/", data: data);
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

  Future<dynamic> validateBankAcc(Request data) async {
    final res = await http.postEncrypted(
      "/app/validate-bank/",
      data: data,
    );
    return res;
  }

  Future<dynamic> uploadImage(
      {required File file, required, required DOCTYPE type}) async {
    List<int> bytes = file.readAsBytesSync();
    String base64Image = base64Encode(bytes);
    String fileName = file.path.split("/").last;
    String mimeType = "image/jpeg";
    final res = await http.post(
      "/app/upload-document/",
      data: {
        "DocumentId": 0,
        "DocumentType": uploadMap[type],
        "FileName": fileName,
        "Latitude": 0,
        "Longitude": 0,
        "FileDataBase64": base64Image,
        "FileType": mimeType,
      },
    );
    return res;
  }

  Future<ImageFile> getDocument(DOCTYPE type) async {
    final image = await http.getImage(
      "/app/document/${uploadMap[type]}",
    );
    print(image);
    File file = File.fromRawPath(image);
    return ImageFile(image: file);
  }

  Future<List<dynamic>> getBankNames() async {
    final res = await http.get("/masters/bank-names/");
    return res;
  }

  Future<List<bank>> getIfscFromCode(String ifsc) async {
    final res = await http.get("/masters/banks/$ifsc");
    return res.map<bank>((e) => bank.fromJson(e)).toList();
  }

  Future<List<bank>> getIFSC({
    required String bankName,
    String? location,
  }) async {
    bankName.replaceAll(" ", "%20");
    final res = await http.post(
      "/masters/banks/$bankName",
      data: {
        "Data": location,
      },
    );
    return res.map<bank>((e) => bank.fromJson(e)).toList();
  }
}
