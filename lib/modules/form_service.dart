import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/image_file.dart';

class FormService {
  final signUpForm = FormGroup(
    {
      'phone': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(10),
        ],
        touched: false,
      ),
      'TnC': FormControl<bool>(validators: [Validators.requiredTrue]),
    },
  );
  final otpForm = FormGroup(
    {
      'otp': FormControl<String>(
        validators: [Validators.required, Validators.minLength(4)],
      ),
      'TnC': FormControl<bool>(validators: [Validators.requiredTrue]),
      'relation': FormControl<int>(
        validators: [Validators.required],
      ),
    },
  );

  final emailOtpForm = FormGroup(
    {
      'otp': FormControl<String>(
        validators: [Validators.required, Validators.minLength(4)],
      ),
      'TnC': FormControl<bool>(validators: [Validators.requiredTrue]),
    },
  );
  final emailForm = FormGroup(
    {
      'googleToggle': FormControl<bool>(value: false),
      'email': FormControl<String>(
        validators: [
          Validators.required,
          Validators.email,
        ],
        touched: false,
      ),
      'TnC': FormControl<bool>(validators: [Validators.requiredTrue]),
      'relation': FormControl<int>(
        validators: [Validators.required],
      ),
    },
  );
  final panForm = FormGroup(
    {
      'pan': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(10),
          Validators.pattern("[A-Z]{5}[0-9]{4}[A-Z]{1}")
        ],
      ),
      'dob': FormControl<DateTime>(
        validators: [Validators.required],
      ),
    },
  );

  final validatePanForm = FormGroup(
    {
      'PAN': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(10),
          Validators.pattern("[A-Z]{5}[0-9]{4}[A-Z]{1}")
        ],
      ),
      'DateOfBirth': FormControl<String>(
        validators: [Validators.required],
      ),
      'KraVerified': FormControl<bool>(
        validators: [Validators.required],
      ),
      'PanVerified': FormControl<bool>(
        validators: [Validators.required],
      ),
      'FirstName': FormControl<String>(
        validators: [Validators.required],
      ),
      'MiddleName': FormControl<String>(
        validators: [Validators.required],
      ),
      'LastName': FormControl<String>(
        validators: [Validators.required],
      ),
    },
  );

  final ifscForm = FormGroup(
    {
      'ifsc': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(11),
          Validators.pattern("[A-Z]{4}[0-9]{7}")
        ],
      ),
    },
  );
  final selectIfscForm = FormGroup(
    {
      'bank': FormControl<String>(
        validators: [Validators.required],
      ),
      'location': FormControl<String>(
        validators: [Validators.required],
      ),
    },
  );

  final bankAccountForm = FormGroup(
    {
      'IFSC': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(11),
          Validators.pattern("[A-Z]{4}[0-9]{7}")
        ],
      ),
      'BankAccountNo': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(11)],
      ),
      'Bank': FormControl<String>(
        validators: [Validators.required],
      ),
      'Branch': FormControl<String>(
        validators: [Validators.required],
      ),
      'BranchCode': FormControl<String>(
        validators: [Validators.required],
      ),
      'CustomerId': FormControl<String>(
        validators: [Validators.required],
      ),
      'MICR_CODE': FormControl<String>(),
      'NameVerified': FormControl<bool>(
        value: false,
      ),
      "Skip": FormControl<bool>(value: false),
    },
  );

  final uploadBankProofForm = FormGroup(
    {
      'BankProof': FormControl<ImageFile>(
        validators: [Validators.required],
      ),
    },
  );
  final uploadPanPhotoForm = FormGroup(
    {
      'PanPhoto': FormControl<ImageFile>(
        validators: [Validators.required],
      ),
    },
  );

  final uploadAddressProof = FormGroup(
    {
      'AddressProofFront': FormControl<ImageFile>(
        validators: [Validators.required],
      ),
      'AddressProofBack': FormControl<ImageFile>(
        validators: [Validators.required],
      ),
      'List': FormControl<List>(
        validators: [Validators.required],
      ),
    },
  );
  final correspondence_address = FormGroup(
    {
      'House/bldg/block': FormControl<String>(
        validators: [
          Validators.required,
        ],
        touched: false,
      ),
      'Street': FormControl<String>(
        validators: [
          Validators.required,
        ],
        touched: false,
      ),
      'Location': FormControl<String>(
        validators: [
          Validators.required,
        ],
        touched: false,
      ),
      'City': FormControl<String>(
        validators: [
          Validators.required,
        ],
        touched: false,
      ),
      'PinCode': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(7),
        ],
        touched: false,
      ),
      'State': FormControl<String>(
        validators: [
          Validators.required,
        ],
        touched: false,
      ),
      'Country': FormControl<String>(
        validators: [
          Validators.required,
        ],
        touched: false,
      ),
      'TnC': FormControl<bool>(validators: [Validators.requiredTrue]),
    },
  );
}
