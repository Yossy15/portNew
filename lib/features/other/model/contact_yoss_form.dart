import 'package:reactive_forms/reactive_forms.dart';

/// ฟอร์มฝากบอก YOSS — ชื่อ / ข้อความ (อีเมลส่งฝั่ง UI คงที่)
abstract final class ContactYossForm {
  static const String nameKey = 'name';
  static const String messageKey = 'message';

  static FormGroup form() {
    return fb.group({
      nameKey: FormControl<String>(
        validators: [_trimmedMinLength(2)],
      ),
      messageKey: FormControl<String>(
        validators: [_trimmedMinLength(5)],
      ),
    });
  }

  /// ตัดช่องว่างหัวท้ายแล้วต้องไม่ว่าง และยาวอย่างน้อย [min] ตัวอักษร
  static Validator<dynamic> _trimmedMinLength(int min) {
    return Validators.delegate((AbstractControl<dynamic> control) {
      final raw = control.value;
      final v = raw is String ? raw.trim() : '';
      if (v.isEmpty) {
        return {ValidationMessage.required: true};
      }
      if (v.length < min) {
        return {
          ValidationMessage.minLength: {
            'requiredLength': min,
            'actualLength': v.length,
          },
        };
      }
      return null;
    });
  }
}
