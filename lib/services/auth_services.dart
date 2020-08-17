import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../models/api_response.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class AuthServices {
  //SignIn
  Future<ApiResponse<FirebaseUser>> signIn(AuthCredential authCreds) async {
    AuthResult response;
    ApiResponse<FirebaseUser> result;

    try {
      response = await _auth.signInWithCredential(authCreds);
      result = ApiResponse<FirebaseUser>(data: response.user, error: false);
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_SESSION_EXPIRED':
          result = ApiResponse<FirebaseUser>(
            error: true,
            errorMessage:
                "The sms verification code has expired. re-send it and try again",
          );
          break;
        case 'ERROR_INVALID_VERIFICATION_CODE':
          result = ApiResponse<FirebaseUser>(
            error: true,
            errorMessage: "The sms verification code is invalid. Try again",
          );
          break;
        case 'ERROR_NETWORK_REQUEST_FAILED':
          result = ApiResponse<FirebaseUser>(
            error: true,
            errorMessage: "Check internet connection",
          );
          break;
        case 'error':
          result = ApiResponse<FirebaseUser>(
            error: true,
            errorMessage: "Invalid Sms code",
          );
          break;
        default:
          result = ApiResponse<FirebaseUser>(
            error: true,
            errorMessage: "There is something error",
          );
      }
    } catch (e) {
      result = ApiResponse<FirebaseUser>(
        error: true,
        errorMessage: "There is something error",
      );
    }

    return result;
  }

  Future<ApiResponse<FirebaseUser>> signInWithOTP(
      String smsCode, String verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
      verificationId: verId,
      smsCode: smsCode,
    );
    return signIn(authCreds);
  }

  // get current user
  Future<ApiResponse<FirebaseUser>> getCurrentUser() async {
    ApiResponse<FirebaseUser> response = await _auth.currentUser().then((user) {
      return ApiResponse<FirebaseUser>(data: user, error: false);
    }).catchError((e) {
      print(e);
      return ApiResponse<FirebaseUser>(
        error: true,
        errorMessage: 'something wrong in get current user',
      );
    });

    return response;
  }

  //Sign out
  signOut() {
    _auth.signOut();
  }
}
