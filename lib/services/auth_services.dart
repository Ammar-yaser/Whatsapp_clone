import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../models/api_response.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class AuthServices {
  //SignIn
  Future<ApiResponse<UserCredential>> signIn(AuthCredential authCreds) async {
    ApiResponse<UserCredential> result;
    try {
      UserCredential response = await _auth.signInWithCredential(authCreds);
      result = ApiResponse<UserCredential>(data: response, error: false);
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_SESSION_EXPIRED':
          result = ApiResponse<UserCredential>(
            error: true,
            errorMessage:
                "The sms verification code has expired. re-send it and try again",
          );
          break;
        case 'ERROR_INVALID_VERIFICATION_CODE':
          result = ApiResponse<UserCredential>(
            error: true,
            errorMessage: "The sms verification code is invalid. Try again",
          );
          break;
        case 'ERROR_NETWORK_REQUEST_FAILED':
          result = ApiResponse<UserCredential>(
            error: true,
            errorMessage: "Check internet connection",
          );
          break;
        case 'error':
          result = ApiResponse<UserCredential>(
            error: true,
            errorMessage: "Invalid Sms code",
          );
          break;
        default:
          result = ApiResponse<UserCredential>(
            error: true,
            errorMessage: "There is something error",
          );
      }
    } catch (e) {
      result = ApiResponse<UserCredential>(
        error: true,
        errorMessage: "There is something error",
      );
    }

    return result;
  }

  Future<ApiResponse<UserCredential>> signInWithOTP(String smsCode, String verId) {
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
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
