class Validator {
  static String? validateName({required String name}) {
    if (name.isEmpty) {
      return 'Please enter username';
    }

    return null;
  }

  static String? validateEmail({required String email}) {
    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Please enter email';
    } else if (!emailExp.hasMatch(email)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  static String? validatePassword({
    required String password,
    String? confirmPassword,
  }) {
    if (password.isEmpty || confirmPassword!.isEmpty) {
      return 'Please enter password';
    } else if (password.length < 8 || confirmPassword.length < 8) {
      return 'Enter a password with length atleast 8 characters';
    }

    if (password != confirmPassword) {
      return 'Passwords don\'t match';
    }

    return null;
  }
}
