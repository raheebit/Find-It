

abstract final class Validators {
  
  static String? required(String? value, {String field = 'هذا الحقل'}) {
    if (value == null || value.trim().isEmpty) {
      return '$field مطلوب.';
    }

    return null;
  }

  static String? email(String? value) {
    final requiredError = required(value, field: 'البريد الإلكتروني');

    if (requiredError != null) {
      return requiredError;
    }

    final pattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    return pattern.hasMatch(value!.trim())
        ? null
        : 'أدخل بريدًا إلكترونيًا صحيحًا.';
  }
}
