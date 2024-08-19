class AppValidators {
  static bool nameValidator(String name) {
    return true;
  }

  static String? emailValidator(String? email) {
    if (email != null) {
      if (email.length < 6 && email.length > 50) {
        return "This field must have a maximum of 50 and a minimum of 6 characters.";
      }
    } else {
      return "This field is required";
    }
    return null;
  }

  static String? emailSimpleValidator(String? email) {
    if (email != null && email.isNotEmpty) {
      return null;
    } else {
      return "This field is required";
    }
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    if (value.length < 10 || value.length > 60) {
      return 'The password must be between 10 and 60 characters long.';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'The password must contain at least one lowercase letter.';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'The password must contain at least one uppercase letter.';
    }

    if (!RegExp(r'\d').hasMatch(value)) {
      return 'The password must contain at least one number.';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'The password must contain at least one special character.';
    }

    return null;
  }

  static String? passwordSimpleValidator(String? password) {
    if (password != null && password.isNotEmpty) {
      return null;
    } else {
      return "This field is required";
    }
  }
}
