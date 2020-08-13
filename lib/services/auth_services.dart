import 'package:firebase_auth/firebase_auth.dart';
import '../models/api_response.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class AuthServices {
  //SignIn
  Future<ApiResponse<FirebaseUser>> signIn(AuthCredential authCreds) async {
    Future<ApiResponse<FirebaseUser>> user =
        _auth.signInWithCredential(authCreds).then((result) {
      return ApiResponse<FirebaseUser>(data: result.user, error: false);
    }).catchError((e) {
      return ApiResponse<FirebaseUser>(
          error: true, errorMessage: "faild to sign in $e");
    });
    return user;
  }

  Future<ApiResponse<FirebaseUser>> signInWithOTP(
      String smsCode, String verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
      verificationId: verId,
      smsCode: smsCode,
    );
    return signIn(authCreds);
  }

  //Sign out
  signOut() {
    _auth.signOut();
  }
}
