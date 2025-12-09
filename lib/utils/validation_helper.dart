class ValidationHelper {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter valid email address';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    return (value?.isEmpty ?? true)
        ? 'Please enter your phone number'
        : value!.length != 11
        ? 'Enter 11 digits (e.g., 09171234567)'
        : !RegExp(r'^[0-9]+$').hasMatch(value)
        ? 'Please enter only numbers'
        : null;
  }

  static String? validateName(String? value) {
    if (value?.isEmpty ?? true) return 'Please enter your name';
    if (value!.length < 3) return 'Name must be 3 characters';
    return null;
  }

  static String? validateAge(String? value) {
    if (value?.isEmpty ?? true) return 'Please enter your age';

    final age = int.tryParse(value!);
    return age == null
        ? 'Please enter a valid number'
        : age < 18
        ? 'Must be 18 and above years old'
        : age > 120
        ? 'Old enough'
        : null;
  }

  static String? validatePassword(String? value) {
    if (value?.isEmpty ?? true) return 'Please enter a password';

    if (value!.length < 6) return 'Password must be at least 6 characters';
    if (!value.contains(RegExp(r'[A-Z]')))
      return 'Password must contain at least one uppercase letter';
    if (!value.contains(RegExp(r'[0-9]')))
      return 'Password must contain at least one number';

    return null;
  }

  static String? validateConfirmPass(String? value, String password) {
    if (value?.isEmpty ?? true) return 'Please enter confirm password';
    if (value != password) return 'Passwords do not match';

    return null;
  }

  static String? validateContry(String? value) {
    if (value?.isEmpty ?? true) return 'Please enter your country or city';

    return null;
  }
}
