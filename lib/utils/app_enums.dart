extension InputValidation on String {
  bool get isValidName {
    final nameRegExp = RegExp(r"^[A-Za-z]+(?:[-'.\s][A-Za-z]+)*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidEmail {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]){3}(?=.*?[!@#\><*~]){2}.{8,}$');
    // RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{6,}$');
    return passwordRegExp.hasMatch(this);
  }
}
