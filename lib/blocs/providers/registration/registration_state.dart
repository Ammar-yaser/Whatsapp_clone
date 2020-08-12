import 'package:flutter/material.dart';
import '../../../services/auth_services.dart';

AuthServices auth = AuthServices();

class RegistState with ChangeNotifier {
  String _phoneCode = '+20', _errorMessage = '', _phone, _smsCode, _autoCode;

  // Setters
  void setPhone(String val) => _phone = "$_phoneCode$val";

  set phoneCode(String val) {
    _phoneCode = val;
    notifyListeners();
  }

  // this is for set 000000 for pin code auto retrive
  set autoCode(String val) {
    _autoCode = val;
    notifyListeners();
  }

  // error of phone number validation
  set errorMessage(String val) {
    if (val == null) {
      _errorMessage = '';
      notifyListeners();
    } else {
      _errorMessage = val;
      notifyListeners();
    }
  }

  // set verification code from pin code fields if user enter it maniually
  void setSmsCode(String val) => _smsCode = val;

  //Getters
  String get phone => _phone;
  String get phoneCode => _phoneCode;
  String get autoCode => _autoCode;
  String get smsCode => _smsCode;
  String get errorMessage => _errorMessage;

  void autoRegistration({Function pinPage, Function homePage}) {
    auth.verifyPhone(
      phone: _phone,
      codeSent: pinPage,
      onAutoVerComplete: (user) {
        _autoCode = '000000';
        homePage(user);
      },
    );
  }
}
