import 'dart:convert';
import 'dart:io';

import 'package:diy/diy.dart';
import 'package:diy/modules/correspondence_address/models/country_dropdown_item.dart';
import 'package:diy/modules/correspondence_address/models/state_dropdown_item.dart';
import 'package:diy/modules/financial-info/models/income_dropdown_item.dart';
import 'package:diy/modules/financial-info/models/occupation_dropdown_item.dart';
import 'package:diy/modules/financial-info/models/trading_experience_dropdown_item.dart';
import 'package:diy/modules/verify-mobile/models/relation_dropdown.dart';
import 'package:diy/network/http_client.dart';
import 'package:diy/network/oauth_service.dart';
import 'package:diy/utils/constants.dart';
import 'package:diy/utils/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../modules/derivativeproof/model/income_dropdown_item.dart';
import '../modules/ifsc/models/bank.dart';
import '../modules/select-plan/models/plan.dart';
import '../utils/libs.dart';

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
    );
    return res;
  }

  Future<dynamic> generateKra() async {
    final res = await http.get(
      "/app/generate-aof/",
    );
    return res;
  }

  Future<dynamic> startESign() async {
    final res = await http.get(
      "/app/kra-esign-start/",
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
      {required File file,
      required,
      required DOCTYPE type,
      double lat = 25.25,
      double long = 81.52}) async {
    List<int> bytes = file.readAsBytesSync();
    String base64Image = base64Encode(bytes);
    String fileName = file.path.split("/").last;
    String mimeType = "image/jpeg";
    final res = await http.post(
      "/app/upload-document/",
      data: {
        "DocumentId": uploadMap[type],
        "DocumentType": uploadMap[type],
        "FileName": fileName,
        "Latitude": lat,
        "Longitude": long,
        "FileDataBase64": base64Image,
        "FileType": mimeType,
        "Status": 0,
        "poaType": "0",
      },
    );
    return res;
  }

  NetworkImage getImage(DOCTYPE type) {
    return NetworkImage(
      "$baseUrl/app/document/${uploadMap[type]}",
      headers: {
        'Authorization': getIt<OAuthService>().token.toString(),
      },
    );
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

  // Future<bool> settings() async {
  //   final res = await http.get("/app/settings/");
  //   return res;
  // }

  Future<dynamic> settings() async {
    final res = await http.get(
      "/app/settings/",
    );
    return res;
  }

  Future<dynamic> digiLocker() async {
    final res = await http.get(
      "/app/digi-locker-journey/",
    );
    return res;
  }

  Future<dynamic> startIPV() async {
    final res = await http.get(
      "/app/ipv-start/",
    );
    return res;
  }

  Future<void> manualJourney() async {
    final res = await http.get("/app/manual-journey/");
    return res;
  }

  Future<List<CountryDropdownItem>> getCountries() async {
    final res = await http.get("/masters/countries");
    return res
        .map<CountryDropdownItem>((e) => CountryDropdownItem.fromJson(e))
        .toList();
  }

  Future<List<StateDropdownItem>> getStates() async {
    final res = await http.get("/masters/states");
    return res
        .map<StateDropdownItem>((e) => StateDropdownItem.fromJson(e))
        .toList();
  }

  Future<dynamic> saveCorrespondenceAddress(Request data) async {
    final res = await http.post(
      "/app/save-correspondence-address/",
      data: data,
    );
    return res;
  }

  Future<dynamic> savePersonalDetails(Request data) async {
    final res = await http.post(
      "/app/save-personal-detail/",
      data: data,
    );
    return res;
  }

  Future<dynamic> saveFinancialInfo(Request data) async {
    final res = await http.post(
      "/app/save-financial-info/",
      data: data,
    );
    return res;
  }

  Future<dynamic> savePlanDetails(Request data) async {
    final res = await http.post(
      "/app/save-plan-details/",
      data: data,
    );
    return res;
  }

  Future<List<OccupationDropdownItem>> getOccupation() async {
    final res = await http.get("/masters/occupations");
    return res
        .map<OccupationDropdownItem>((e) => OccupationDropdownItem.fromJson(e))
        .toList();
  }

  Future<List<AnnualIncomeDropdownItem>> getIncome() async {
    final res = await http.get("/masters/annual-incomes");
    return res
        .map<AnnualIncomeDropdownItem>(
            (e) => AnnualIncomeDropdownItem.fromJson(e))
        .toList();
  }

  Future<List<IncomeProofDropdownItem>> getIncomeProof() async {
    final res = await http.get("/masters/income-proofs");
    return res
        .map<IncomeProofDropdownItem>(
            (e) => IncomeProofDropdownItem.fromJson(e))
        .toList();
  }

  Future<List<StateDropdownItem>> getEmployers() async {
    final res = await http.get("/masters/employers");
    return res
        .map<StateDropdownItem>((e) => StateDropdownItem.fromJson(e))
        .toList();
  }

  Future<List<StateDropdownItem>> getDesignations() async {
    final res = await http.get("/masters/designations");
    return res
        .map<StateDropdownItem>((e) => StateDropdownItem.fromJson(e))
        .toList();
  }

  Future<List<TradingExperienceDropdownItem>> getTradingExperience() async {
    final res = await http.get("/masters/trading-experiences");
    return res
        .map<TradingExperienceDropdownItem>(
            (e) => TradingExperienceDropdownItem.fromJson(e))
        .toList();
  }

  Future<List<plan>> getPlans(int planType) async {
    final res = await http.get("/masters/plans/$planType");
    final ret = res.map<plan>((e) => plan.fromJson(e)).toList();
    return ret;
  }
}
