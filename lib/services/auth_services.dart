import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

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
  String userId;

  Future<FirebaseUser> verifyPhone(
      {String phone, Function codeSent, VoidCallback autoCode}) async {
    FirebaseUser user;
    final PhoneVerificationCompleted verified =
        (AuthCredential credential) async {
      FirebaseUser result = await signIn(credential);
      if (result != null) {
        autoCode();
        user = result;
      }
    };

    final PhoneVerificationFailed verificationfailed = (AuthException authE) {
      print('Error: ${authE.code}');
      // if (authE.code == "quotaExceeded") block request from this device
      //     setState(() {
      //   status = '${authException.message}';

      //   print("Error message: " + status);
      //   if (authException.message.contains('not authorized'))
      //     status = 'Something has gone wrong, please try later';
      //   else if (authException.message.contains('Network'))
      //     status = 'Please check your internet connection and try again';
      //   else
      //     status = 'Something has gone wrong, please try later';
      // });
    };

    final PhoneCodeSent smsSent = (String verificationId, [int forceResend]) {
      codeSent();
      verId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verificationId) {
      verId = verificationId;
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 30),
      verificationCompleted: verified,
      verificationFailed: verificationfailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );

    return user;
  }

  //SignIn
  Future<FirebaseUser> signIn(AuthCredential authCreds) async {
    Future<FirebaseUser> user = _auth
        .signInWithCredential(authCreds)
        .then((result) => result.user)
        .catchError((e) {
      print("sms code is not true");
    });
    return user;
  }

  Future<FirebaseUser> signInWithOTP(String smsCode) {
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
