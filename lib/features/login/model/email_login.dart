import 'package:reactive_forms/reactive_forms.dart';

class LoginEmail {
  static FormGroup form() {
    return fb.group({
      'email': FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
      'password': FormControl<String>(
        validators: [Validators.required, Validators.minLength(6)],
      ),
    });
  }
}