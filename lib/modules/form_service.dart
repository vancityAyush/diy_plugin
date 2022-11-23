import 'package:reactive_forms/reactive_forms.dart';

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
}