import 'package:flutter/material.dart';

class RegistState with ChangeNotifier {
  String _phoneCode = '+20', _phone, _smsCode, _autoCode;
  TextEditingController _pinController;

  // Setters
  void setPhone(String val) {
    _phone = "$_phoneCode$val";
  }
  set phoneCode(String val) {
    _phoneCode = val;
    notifyListeners();
  }
  set autoCode(String val) {
    _autoCode = val;
    notifyListeners();
  }
  void setSmsCode(String val) => _smsCode = val;
  void setController(TextEditingController controller) =>
      _pinController = controller;

  //Getters
  String get phone => _phone;
  String get phoneCode => _phoneCode;
  String get autoCode => _autoCode;
  String get smsCode => _smsCode;
  TextEditingController get pinController => _pinController;

  registration() {}
}
