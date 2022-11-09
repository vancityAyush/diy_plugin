import 'package:json_annotation/json_annotation.dart';

import 'auth_token.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? MobileRelationshipId;
  String? Email;
  String? FirstName;
  String? MiddleName;
  String? LastName;
  String? FullName;
  String? PAN;
  String? DateOfBirth;
  String? IFSC;
  dynamic BankAccountNo;
  String? BankName;
  dynamic CustomerId;
  String? BranchCode;
  String? MICR_CODE;
  String? BankBranch;
  dynamic Gender;
  String? GenderName;
  int? MaritalStatus;
  String? MaritalStatusName;
  dynamic FatherName;
  dynamic MotherName;
  dynamic CorrespondenceHouseNo;
  dynamic CorrespondenceStreet;
  dynamic CorrespondenceLocation;
  dynamic CorrespondenceCity;
  dynamic CorrespondencePincode;
  int? CorrespondenceState;
  dynamic CorrespondenceStateName;
  dynamic CorrespondenceStateCode;
  dynamic CorrespondenceDistrict;
  int? CorrespondenceCountry;
  int? CorrespondenceCountryCode;
  dynamic CorrespondenceCountryName;
  bool? IsPermanentSame;
  dynamic PermanentHouseNo;
  dynamic PermanentStreet;
  dynamic PermanentLocation;
  dynamic PermanentCity;
  dynamic PermanentPincode;
  int? PermanentState;
  dynamic PermanentStateName;
  int? PermanentCountry;
  dynamic PermanentCountryName;
  dynamic Education;
  int? AnnualIncome;
  dynamic AnnualIncomeName;
  int? Occupation;
  dynamic OccupationName;
  dynamic CompanyName;
  dynamic Designation;
  int? TradingExperience;
  dynamic TradingExperienceName;
  bool? IsIndianCitizen;
  bool? IsNotPEP;
  bool? IsRelatedPEP;
  int? CountryOfResidence;
  dynamic TIN;
  dynamic TaxIdentificationType;
  bool? OtherBroker;
  dynamic BrokerName;
  dynamic BrokerCode;
  bool? Nomination;
  String? PromoCode;
  int? PlanId;
  int? PlanType;
  int? IncomeProofType;
  bool? IsCashMf;
  bool? IsCommodity;
  dynamic LgCode;
  dynamic SourceCode;
  bool? IsLgLcCodeFilled;
  String? Source;
  bool? NewDiy;
  String? CreatedOn;
  String? ModifiedOn;
  String? LastStageCompleted;
  dynamic Steps;
  AuthBean? Auth;
  bool? KraVerified;
  String? ApprovedOn;
  dynamic EmployeeCode;
  bool? RequireBankUpload;
  bool? RequireIncomeProof;
  bool? RequirePromoProof;
  dynamic cAddress1;
  dynamic cAddress2;
  dynamic cAddress3;
  dynamic pAddress1;
  dynamic pAddress2;
  dynamic pAddress3;
  dynamic PermanentStateCode;
  dynamic PermanentDistrict;
  dynamic PermanentCountryCode;
  dynamic VerDesignation;
  dynamic IpvDetails;
  dynamic Utm;
  bool? DdpiOpted;
  bool? MtfOpted;
  bool? KraAofApplicable;
  int? ApplicationId;
  String? UAN;
  String? Mobile;
  int? ApplicationStatus;
  int? Mode;
  dynamic LcCode;
  dynamic LastSubmittedOn;

  User(
      {this.MobileRelationshipId,
      this.Email,
      this.FirstName,
      this.MiddleName,
      this.LastName,
      this.FullName,
      this.PAN,
      this.DateOfBirth,
      this.IFSC,
      this.BankAccountNo,
      this.BankName,
      this.CustomerId,
      this.BranchCode,
      this.MICR_CODE,
      this.BankBranch,
      this.Gender,
      this.GenderName,
      this.MaritalStatus,
      this.MaritalStatusName,
      this.FatherName,
      this.MotherName,
      this.CorrespondenceHouseNo,
      this.CorrespondenceStreet,
      this.CorrespondenceLocation,
      this.CorrespondenceCity,
      this.CorrespondencePincode,
      this.CorrespondenceState,
      this.CorrespondenceStateName,
      this.CorrespondenceStateCode,
      this.CorrespondenceDistrict,
      this.CorrespondenceCountry,
      this.CorrespondenceCountryCode,
      this.CorrespondenceCountryName,
      this.IsPermanentSame,
      this.PermanentHouseNo,
      this.PermanentStreet,
      this.PermanentLocation,
      this.PermanentCity,
      this.PermanentPincode,
      this.PermanentState,
      this.PermanentStateName,
      this.PermanentCountry,
      this.PermanentCountryName,
      this.Education,
      this.AnnualIncome,
      this.AnnualIncomeName,
      this.Occupation,
      this.OccupationName,
      this.CompanyName,
      this.Designation,
      this.TradingExperience,
      this.TradingExperienceName,
      this.IsIndianCitizen,
      this.IsNotPEP,
      this.IsRelatedPEP,
      this.CountryOfResidence,
      this.TIN,
      this.TaxIdentificationType,
      this.OtherBroker,
      this.BrokerName,
      this.BrokerCode,
      this.Nomination,
      this.PromoCode,
      this.PlanId,
      this.PlanType,
      this.IncomeProofType,
      this.IsCashMf,
      this.IsCommodity,
      this.LgCode,
      this.SourceCode,
      this.IsLgLcCodeFilled,
      this.Source,
      this.NewDiy,
      this.CreatedOn,
      this.ModifiedOn,
      this.LastStageCompleted,
      this.Steps,
      this.Auth,
      this.KraVerified,
      this.ApprovedOn,
      this.EmployeeCode,
      this.RequireBankUpload,
      this.RequireIncomeProof,
      this.RequirePromoProof,
      this.cAddress1,
      this.cAddress2,
      this.cAddress3,
      this.pAddress1,
      this.pAddress2,
      this.pAddress3,
      this.PermanentStateCode,
      this.PermanentDistrict,
      this.PermanentCountryCode,
      this.VerDesignation,
      this.IpvDetails,
      this.Utm,
      this.DdpiOpted,
      this.MtfOpted,
      this.KraAofApplicable,
      this.ApplicationId,
      this.UAN,
      this.Mobile,
      this.ApplicationStatus,
      this.Mode,
      this.LcCode,
      this.LastSubmittedOn});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String?, dynamic> toJson() => _$UserToJson(this);
}
