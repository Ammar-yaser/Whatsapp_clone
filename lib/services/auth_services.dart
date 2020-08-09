
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class AuthServices {
  //Handles Auth
  // handleAuth() {
  //   return StreamBuilder(
  //       stream: _auth.onAuthStateChanged,
  //       builder: (BuildContext context, snapshot) {
  //         if (snapshot.hasData) {
  //           return DashboardPage();
  //         } else {
  //           return LoginPage();
  //         }
  //       });
  // }

  String verId;
  String smsCode;

  Future<void> verifyPhone(phone,Function pinCodePage) async {
    final PhoneVerificationCompleted verified =
        (AuthCredential credential) async {
      debugPrint('used');
      signIn(credential).then(
            (user) =>
                user == null ? print('Failed signed in') : print("Signed in"),
          );
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('Error: ${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verificationId, [int forceResend]) {
      pinCodePage();
      verId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verificationId) {
      verId = verificationId;
      print('finished time');
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 30),
      verificationCompleted: verified,
      verificationFailed: verificationfailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }

  //SignIn
  Future<FirebaseUser> signIn(AuthCredential authCreds) async {
    AuthResult result = await _auth.signInWithCredential(authCreds);
    print(result.additionalUserInfo.isNewUser);

    return result.user;
  }

  Future<FirebaseUser> signInWithOTP(String smsCode, String verId) {
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
