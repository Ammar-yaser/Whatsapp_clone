import 'package:firebase_auth/firebase_auth.dart';
import '../models/api_response.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class AuthServices {
  //SignIn
  Future<ApiResponse<FirebaseUser>> signIn(AuthCredential authCreds) async {
    Future<ApiResponse<FirebaseUser>> response =
        _auth.signInWithCredential(authCreds).then((result) {
      // result.additionalUserInfo.isNewUser;
      return ApiResponse<FirebaseUser>(data: result.user, error: false);
    }).catchError((e) {
      return ApiResponse<FirebaseUser>(
          error: true, errorMessage: "faild to sign in $e");
    });
    return response;
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
      return ApiResponse<FirebaseUser>(
          error: true, errorMessage: 'something wrong in get current user');
    });

    return response;
  }

  //Sign out
  signOut() {
    _auth.signOut();
  }
}
