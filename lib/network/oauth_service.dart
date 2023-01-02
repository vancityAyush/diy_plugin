import 'dart:async';

import 'package:diy/modules/form_service.dart';
import 'package:diy/network/http_client.dart';
import 'package:diy/network/models/token.dart';
import 'package:diy/network/models/ui_status.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../diy.dart';
import '../utils/util.dart';
import 'models/Response.dart';
import 'models/auth_token.dart';
import 'models/user.dart';

class OAuthService {
  final HttpClient _http;
  final FlutterSecureStorage _storage;
  final dummyUser = User();

  final FormService _formService = getIt<FormService>();

  void resetForms() {
    _formService.signUpForm.reset();
    _formService.emailForm.reset();
    _formService.panForm.reset();
    _formService.validatePanForm.reset();
    _formService.selectIfscForm.reset();
    //TODO Complete it
  }

  void patchForm() {
    _formService.signUpForm.control('phone').value = currentUser!.Mobile ?? "";
    _formService.emailForm.control('email').value = currentUser!.Email ?? "";
    _formService.panForm.control('pan').value = currentUser!.PAN ?? "";
    _formService.panForm.control('dob').value = DateTime.parse(
        currentUser!.DateOfBirth ?? DateTime(2000 - 01 - 01).toString());
    _formService.validatePanForm.control('PAN').value = currentUser!.PAN ?? "";
    _formService.validatePanForm.control('DateOfBirth').value =
        currentUser!.DateOfBirth ?? "";
    _formService.validatePanForm.control('KraVerified').value =
        currentUser!.KraVerified ?? true;
    //PanVarified not found in user model
    //_formService.validatePanForm.control('PanVerified').value = currentUser!.  ?? "";
    _formService.validatePanForm.control('FirstName').value =
        currentUser!.FirstName ?? "";
    _formService.validatePanForm.control('MiddleName').value =
        currentUser!.MiddleName ?? "";
    _formService.validatePanForm.control('LastName').value =
        currentUser!.LastName ?? "";
    _formService.ifscForm.control('ifsc').value = currentUser!.IFSC ?? "";
    _formService.selectIfscForm.control('bank').value =
        currentUser!.BankName ?? "";
    _formService.selectIfscForm.control('location').value =
        currentUser!.BankBranch ?? "";
    _formService.bankAccountForm.control('IFSC').value =
        currentUser!.IFSC ?? "";
    _formService.bankAccountForm.control('BankAccountNo').value =
        currentUser!.BankAccountNo ?? "";
    _formService.bankAccountForm.control('Bank').value =
        currentUser!.BankName ?? "";
    _formService.bankAccountForm.control('Branch').value =
        currentUser!.BankBranch ?? "";
    _formService.bankAccountForm.control('BranchCode').value =
        currentUser!.BranchCode ?? "";
    _formService.bankAccountForm.control('CustomerId').value =
        currentUser!.CustomerId ?? "";
    _formService.bankAccountForm.control('MICR_CODE').value =
        currentUser!.MICR_CODE ?? "";
    //Skipped uploadBankProofForm
    _formService.correspondence_address.control('CorrespondenceHouseNo').value =
        currentUser!.CorrespondenceHouseNo ?? "";
    _formService.correspondence_address.control('CorrespondenceStreet').value =
        currentUser!.CorrespondenceStreet ?? "";
    _formService.correspondence_address
        .control('CorrespondenceStateName')
        .value = currentUser!.CorrespondenceStateName ?? "";
    _formService.correspondence_address
        .control('CorrespondenceLocation')
        .value = currentUser!.CorrespondenceLocation ?? "";
    _formService.correspondence_address.control('CorrespondenceState').value =
        currentUser!.CorrespondenceState ?? "";
    _formService.correspondence_address
        .control('CorrespondenceCountryName')
        .value = currentUser!.CorrespondenceCountryName ?? "";
    _formService.correspondence_address.control('CorrespondenceCountry').value =
        currentUser!.CorrespondenceCountry ?? "";
    _formService.correspondence_address.control('CorrespondenceCity').value =
        currentUser!.CorrespondenceCity ?? "";
    _formService.correspondence_address.control('CorrespondencePincode').value =
        currentUser!.CorrespondencePincode ?? "";
    _formService.correspondence_address.control('CorrespondenceState').value =
        currentUser!.CorrespondenceState ?? "";
    _formService.correspondence_address.control('State').value =
        currentUser!.CorrespondenceState ?? "";
    _formService.correspondence_address.control('Country').value =
        currentUser!.CorrespondenceCountry ?? "";
    _formService.personalDetails.control('Gender').value =
        currentUser!.Gender ?? "";
    _formService.personalDetails.control('MaritalStatus').value =
        currentUser!.MaritalStatus ?? "";
    _formService.personalDetails.control('FatherName').value =
        currentUser!.FatherName ?? "";
    _formService.personalDetails.control('MotherName').value =
        currentUser!.MotherName ?? "";
    _formService.financialInfo.control('Education').value =
        currentUser!.Education ?? "";
    _formService.financialInfo.control('AnnualIncome').value =
        currentUser!.AnnualIncome ?? "";
    _formService.financialInfo.control('Occupation').value =
        currentUser!.Occupation ?? "";
    _formService.financialInfo.control('TradingExperience').value =
        currentUser!.TradingExperience ?? "";
    _formService.selectPlan.control('PlanType').value =
        currentUser!.PlanType ?? "";
    _formService.selectPlan.control('PlanId').value = currentUser!.PlanId ?? "";
    _formService.selectPlan.control('DdpiOpted').value =
        currentUser!.DdpiOpted ?? "";
  }

  UiStatus uiStatus = UiStatus(NextModuleId: 1, BackMenuList: []);

  Token token = Token();

  OAuthService(this._http, this._storage);

  StreamController<User?> userController = StreamController<User>();
  User? currentUser;
  dynamic response;

  Stream<User?> get authStateChange {
    return userController.stream;
  }

  Future<ResponseModel> sendEmailOtp(
      {required String email, int? relationId}) async {
    try {
      relationId = relationId ?? response["EmailRelationshipId"];
      final res = await _http.post(
        "/app/send-email-otp/",
        data: {
          "Email": email,
          "EmailRelationshipId": relationId,
        },
      );
      if (res != null) {
        response = res;
        return ResponseModel(status: true, arguments: "Otp Sent Successfully");
      } else {
        return ResponseModel(status: false, arguments: res["ErrorMessage"]);
      }
    } on HttpException catch (e) {
      AppUtil.showErrorToast(e.error["ErrorMessage"]);
      print(e);
    } catch (e) {
      print(e);
    }
    return ResponseModel(status: false, arguments: "Something went wrong");
  }

  Future<ResponseModel> validateEmail({
    required String otp,
  }) async {
    try {
      final res = await _http.postEncrypted(
        "/app/validate-email/",
        data: {
          "Email": response["Email"],
          "EmailRelationshipId": response["EmailRelationshipId"],
          "Otp": otp,
          "RefId": response["RefId"],
        },
      );
      return ResponseModel(status: true, arguments: res);
    } catch (e) {
      print(e);
      return ResponseModel(status: false, arguments: "Something went wrong");
    }
  }

  Future<UiStatus?> getUIStatus() async {
    try {
      final res = await _http.get("/ui/status");
      return UiStatus.fromJson(res);
    } on HttpException catch (e) {
      print(e);
    }
    return null;
  }

  Future<String> updateUiStatus() async {
    final res = await getUIStatus();
    if (res != null) {
      uiStatus = res;
    }
    return uiStatus.currentRoute;
  }

  Future<void> initState() async {
    // bool isTokenValid = await token.readToken();
    if (false) {
      await sendOtp("9988776654");
      await verifyOtp("1234");
    }
  }

  Future<dynamic> logout() async {
    await _storage.deleteAll();
    userController.add(dummyUser);
    await _http.get("/app/logout/");
  }

  Future<void> refreshToken() async {
    try {
      final res = await _http.post("/auth/refresh/", data: {
        "RefreshToken": token.refreshToken,
        "Token": token.token,
      });
      token.setToken(AuthBean.fromJson(res));
    } on HttpException catch (e) {
      print(e);
      await logout();
    }
  }

  Future<ResponseModel> sendOtp(String phone) async {
    try {
      response = await startAuth(phone);
      if (response != null) {
        return ResponseModel(
          status: true,
          arguments: "OTP sent successfully",
        );
      } else {
        return ResponseModel(status: false, arguments: "Error sending OTP");
      }
    } catch (e) {
      print(e);
      return ResponseModel(status: false, arguments: e);
    }
  }

  Future<ResponseModel> verifyOtp(String otp, {int relationId = 1}) async {
    try {
      User user = await verifyAuth(response["Mobile"], otp, response["RefId"],
          relationshipId: relationId);
      currentUser = user;
      patchForm();
      token.setToken(user.Auth!);
      return ResponseModel(status: true, arguments: "User Verified");
    } catch (e) {
      print(e);
      return ResponseModel(status: false, arguments: e);
    }
  }

  Future<dynamic> startAuth(String mobile) async {
    final rsaEncrypter = _http.rsaEncrypter;
    try {
      final response = await _http.post(
        "/auth/start/",
        data: {
          "Mobile": rsaEncrypter.encrypt(mobile),
          "Source": 1,
          "IsEnableWhatsApp": true,
        },
      );
      return response;
    } on HttpException catch (e) {
      print(e);
      Get.snackbar("Error", e.cause);
    }
  }

  Future<User> verifyAuth(String mobile, String code, String refId,
      {int relationshipId = 1}) async {
    final response = await _http.post(
      "/auth/validate-mobile/",
      data: {
        "Source": 1,
        "IsLpRedirect": false,
        "Mobile": mobile,
        "AppExists": true,
        "RefId": refId,
        "MobileRelationshipId": relationshipId,
        "Otp": code
      },
    );
    return User.fromJson(response);
  }
}
