import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../../models/User_Model.dart';
import '../../../models/api_response.dart';
import '../../../services/auth_services.dart';
import '../../../services/user_info_services.dart';
import '../../../services/shared_pref_services.dart';

AuthServices auth = AuthServices();
UserDataServices userDataServices = UserDataServices();
SharedPrefServices prefServices = SharedPrefServices();

class UserInfoState with ChangeNotifier {
  String _name, _about, _imageUrl;

  bool _isLoading = false;

  set name(String val) => _name = val;
  set about(String val) => _about = val;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  Future<void> saveUserInfo() async {
    ApiResponse<FirebaseUser> currentUser = await auth.getCurrentUser();
    if (!currentUser.error) {
      isLoading = true;
      User userData = User(
        userId: currentUser.data.uid,
        mobile: currentUser.data.phoneNumber,
        name: _name,
        about: _about,
      );
      await userDataServices.createUserData(userData).then((_) {
        isLoading = false;
        prefServices.setLocalUserData(userData);
      }).catchError((e) {
        print(e);
      });
    }
  }
}
