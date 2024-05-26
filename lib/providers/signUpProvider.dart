import 'package:bicycle_renting/services/authService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _loading = false;
  bool get loading => _loading;
  bool _passwordVisible = false;
  bool get passwordVisible => _passwordVisible;
  Future<Map> signUpUser(String email, String pass, String name) async {
    _loading = true;
    notifyListeners();
    Map? msg = await _authService.signUpUser(email, pass, name);
    _loading = false;
    notifyListeners();
    return msg;
  }

  void passVisible() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }
}
