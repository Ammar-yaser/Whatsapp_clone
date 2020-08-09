import 'package:flutter/material.dart';

class RegistState with ChangeNotifier {
  String _phoneCode = '+20', _phone;
  TextEditingController _pinController;

  // Setters
  void setPhone(String val) {
    _phone = "$_phoneCode$val";
  }
  set phoneCode(String val) {
    _phoneCode = val;
    notifyListeners();
  }
  void setController(TextEditingController controller) {
    _pinController = controller;
  }
 
  //Getters
  String get phone => _phone;
  String get phoneCode => _phoneCode;
  TextEditingController get pinController => _pinController;


  registration() {
    
  }
}
