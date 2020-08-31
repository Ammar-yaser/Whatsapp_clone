import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../models/api_response.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class AuthServices {
  //SignIn
  Future<ApiResponse<User>> signIn(AuthCredential authCreds) async {
    UserCredential response;
    ApiResponse<User> result;

    try {
      response = await _auth.signInWithCredential(authCreds);
      result = ApiResponse<User>(data: response.user, error: false);
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_SESSION_EXPIRED':
          result = ApiResponse<User>(
            error: true,
            errorMessage:
                "The sms verification code has expired. re-send it and try again",
          );
          break;
        case 'ERROR_INVALID_VERIFICATION_CODE':
          result = ApiResponse<User>(
            error: true,
            errorMessage: "The sms verification code is invalid. Try again",
          );
          break;
        case 'ERROR_NETWORK_REQUEST_FAILED':
          result = ApiResponse<User>(
            error: true,
            errorMessage: "Check internet connection",
          );
          break;
        case 'error':
          result = ApiResponse<User>(
            error: true,
            errorMessage: "Invalid Sms code",
          );
          break;
        default:
          result = ApiResponse<User>(
            error: true,
            errorMessage: "There is something error",
          );
      }
    } catch (e) {
      result = ApiResponse<User>(
        error: true,
        errorMessage: "There is something error",
      );
    }

    return result;
  }

  Future<ApiResponse<User>> signInWithOTP(String smsCode, String verId) {
    AuthCredential authCreds = PhoneAuthProvider.credential(
      verificationId: verId,
      smsCode: smsCode,
    );
    return signIn(authCreds);
  }

  // get current user
  User getCurrentUser() {
    return _auth.currentUser;
  }

  //Sign out
  signOut() {
    _auth.signOut();
  }
}
