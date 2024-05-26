import 'package:bicycle_renting/services/authService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LogInProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _loading = false;
  bool get loading => _loading;
  bool _passwordVisible = false;
  bool get passwordVisible => _passwordVisible;
  Future<Map> logIn(String email, String pass) async {
    _loading = true;
    notifyListeners();
    Map? msg = await _authService.signInUsingEmailPassword(email, pass);
    _loading = false;
    notifyListeners();
    return msg;
  }

  void passVisible() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }
}
