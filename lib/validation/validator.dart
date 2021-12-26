class Validator {
  static String _emailRegExp = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static String? emailValidator(String? email) {
    if (email!.trim().isEmpty) return 'Email is Required.';
    if (!RegExp(_emailRegExp).hasMatch(email)) return 'Invalid format.';
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password!.trim().isEmpty) return 'Password is Required.';
    if (password.length < 6) return 'Password must be at least 6 characters.';
    if (password.length > 100) return 'Password must be at most 1000 character.';
    return null;
  }

  static String? passwordLoginValidator(String? password) {
    if (password!.trim().isEmpty) return 'Password is Required.';
    return null;
  }
}
