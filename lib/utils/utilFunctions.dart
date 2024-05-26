import 'package:flutter/material.dart';

class MyFunct {
  static String getStringFromJson(Map<String, dynamic> json, String field0) {
    if (json.containsKey(field0) && json[field0] != null) {
      return json[field0].toString();
    }
    return '';
  }

  static double getDoubleFromJson(Map<String, dynamic> json, String field0) {
    return ((json[field0] != null) && (json[field0].toString() != ''))
        ? double.parse(json[field0].toString())
        : 0.0;
  }

  static void showErrorMessage(String message0, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message0,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 4),
      backgroundColor: Colors.red.shade800,
    ));
  }

  static void showMessage(String message0, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message0,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 4),
      backgroundColor: Colors.green,
    ));
  }
}
