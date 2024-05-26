import 'package:bicycle_renting/utils/app_enums.dart';

String? nameValidation(String? name) {
  if (name == null || name.isEmpty) {
    return 'Name can not be empty';
  } else if (InputValidation(name).isValidName) {
    return null;
  } else {
    return 'Invalid Name';
  }
}

String? emailValidation(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email Cannot be empty';
  } else if (InputValidation(email).isValidEmail) {
    return null;
  } else {
    return 'Invalid Email';
  }
}

String? passwordValidation(String? password) {
  if (password == null || password.isEmpty) {
    return 'Password cannot be empty';
  } else if (password.length < 8) {
    return 'Password must be at least 8 characters';
  } else if (!InputValidation(password).isValidPassword) {
    return "Your password must contain a minimum of 8 characters consisting of uppercase and lowercase letters with at least 3 numerical character and 3 symbols.";
  } else {
    return null;
  }
}

String? notEmpty(String? val) {
  if (val == null || val.isEmpty) {
    return 'This can not be empty';
  } else {
    return null;
  }
}
