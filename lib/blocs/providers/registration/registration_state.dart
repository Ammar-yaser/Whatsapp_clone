import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../services/auth_services.dart';
import '../../../models/api_response.dart';

AuthServices auth = AuthServices();
FirebaseAuth _auth = FirebaseAuth.instance;

class RegistState with ChangeNotifier {
  String _phoneCode = '+20',
      _phone,
      _errorMessage = '',
      _autoCode,
      _smsCode,
      _verId;

  bool _isTimeout = false;

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
  set setSmsCode(String val) => _smsCode = val;
  set isTimeout(bool val) {
    _isTimeout = val;
    notifyListeners();
  }

  //Getters
  String get phoneCode => _phoneCode;
  // String get phone => _phone;
  String get errorMessage => _errorMessage;
  String get autoCode => _autoCode;
  // String get smsCode => _smsCode;
  bool get isTimeout => _isTimeout;

  // phone number verfication and auto retriev sms code
  Future<void> verifyPhone({Function pinPage}) async {
    final PhoneVerificationCompleted verified = (AuthCredential cred) async {
      ApiResponse<FirebaseUser> response = await auth.signIn(cred);
      if (!response.error) {
        autoCode = '000000';
      }
    };

    final PhoneVerificationFailed verificationfailed = (AuthException e) {
      switch (e.code) {
        case "invalidCredential":
          errorMessage = "incorrect Phone number";
          break;
        case "verifyPhoneNumberError":
          errorMessage = "Check internet connection";
          break;
        default:
          print(e.code);
      }
    };

    final PhoneCodeSent smsSent = (String verificationId, [int forceResend]) {
      pinPage();
      _verId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verificationId) {
      _verId = verificationId;
      isTimeout = true;
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: _phone,
      timeout: Duration(seconds: 30),
      verificationCompleted: verified,
      verificationFailed: verificationfailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }

  // Registration maniually if auto retriev timedout
  Future<ApiResponse<FirebaseUser>> maniualRegistration() async {
    ApiResponse<FirebaseUser> result =
        await auth.signInWithOTP(_smsCode, _verId);
    return result;
  }
}
