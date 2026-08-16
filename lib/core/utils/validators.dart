abstract final class Validators {
  static String? required(String? value, {String field = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required.';
    }
    return null;
  }

  static String? email(String? value) {
    final requiredError = required(value, field: 'Email');
    if (requiredError != null) return requiredError;

    final pattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return pattern.hasMatch(value!.trim()) ? null : 'Enter a valid email.';
  }
}
