import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/User_Model.dart';
import 'package:whatsapp_clone/services/shared_pref_services.dart';
import '../../../services/auth_services.dart';
import '../../../models/api_response.dart';

AuthServices authServices = AuthServices();
SharedPrefServices prefServices = SharedPrefServices();
FirebaseAuth _auth = FirebaseAuth.instance;

class RegistState with ChangeNotifier {
  String _phoneCode = '+20', // country code picker
      _phone, // phone number picker
      _errorVerMessage = '', // the errors of verification phone number
      _smsCode, // sms code picker from user if auto retriev failed
      _verId, // verification id used for sign in with credential maniually
      _userId;

  bool _isTimeout = false, // for auto retriev timeout
      _isLoading = false, // for modal progress hud to display loading indicator
      _isNewUser = false;

  // Setters
  void setPhone(String val) => _phone = "$_phoneCode$val";
  set phoneCode(String val) {
    _phoneCode = val;
    notifyListeners();
  }

  // error of phone number validation
  set errorVerMessage(String val) {
    if (val == null) {
      _errorVerMessage = '';
      notifyListeners();
    } else {
      _errorVerMessage = val;
      notifyListeners();
    }
  }

  // set verification code from pin code fields if user enter it maniually
  set setSmsCode(String val) => _smsCode = val;
  set setUserId(String val) => _userId = val;
  set isTimeout(bool val) {
    _isTimeout = val;
    notifyListeners();
  }

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  //Getters
  String get phoneCode => _phoneCode;
  String get errorVerMessage => _errorVerMessage;
  String get userId => _userId;
  bool get isTimeout => _isTimeout;
  bool get isLoading => _isLoading;
  bool get isNewUser => _isNewUser;

  // phone number verfication and auto retrieval sms code
  Future<void> verifyPhone(
      {Function pinPage, Function onAutoRetrievComplete}) async {
    final PhoneVerificationCompleted verified = (AuthCredential cred) async {
      isLoading = true;

      ApiResponse<UserCredential> response = await authServices.signIn(cred);
      if (!response.error) {
        isLoading = false;
        _isNewUser = response.data.additionalUserInfo.isNewUser;
        UserModel userData = UserModel(
          userId: response.data.user.uid,
          mobile: response.data.user.phoneNumber,
        );
        prefServices.setLocalUserData(userData: userData, isRemembered: true);
        _userId = userData.userId;
        onAutoRetrievComplete();
      }
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException e) {
      switch (e.code) {
        case "invalid-phone-number":
          errorVerMessage = "incorrect Phone number";
          break;
        case "network-request-failed":
          errorVerMessage = "No internet connection";
          break;
        default:
          errorVerMessage = e.code;
      }
      isLoading = false;
    };

    final PhoneCodeSent smsSent = (String verificationId, [int forceResend]) {
      isLoading = false;
      pinPage();
      _verId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verificationId) {
      _verId = verificationId;
      isTimeout = true;
    };

    isLoading = true;
    await _auth.verifyPhoneNumber(
      phoneNumber: _phone,
      timeout: Duration(seconds: 30),
      verificationCompleted: verified,
      verificationFailed: verificationfailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
      // forceResendingToken: _resendToken
    );
  }

  // Registration maniually if auto retriev timedout
  Future<ApiResponse<UserCredential>> maniualRegistration() async {
    ApiResponse<UserCredential> result =
        await authServices.signInWithOTP(_smsCode, _verId);

    if (result.error == false) {
      UserModel userData = UserModel(
        userId: result.data.user.uid,
        mobile: result.data.user.phoneNumber,
      );
      prefServices.setLocalUserData(userData: userData, isRemembered: true);
      _userId = userData.userId;
    }

    return result;
  }

  Future<void> signOut() async {
    await authServices.signOut();
    User currentUser = authServices.getCurrentUser();
    if (currentUser == null) {
      prefServices.setLocalUserData(isRemembered: false);
    }
  }
}
