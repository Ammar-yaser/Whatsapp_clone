import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/models/User_Model.dart';
import 'package:whatsapp_clone/models/api_response.dart';
import 'package:whatsapp_clone/services/auth_services.dart';
import 'package:whatsapp_clone/services/user_info_services.dart';

AuthServices auth = AuthServices();
UserDataServices userDataServices = UserDataServices();

class UserInfoState {
  String _name, _about, _imageURL;

  set name(String val) => _name = val;
  set about(String val) => _about = val;

  Future<FirebaseUser> currentUser() async {
    ApiResponse<FirebaseUser> result = await auth.getCurrentUser();

    if (!result.error) {
      return result.data;
    } else {
      return null;
    }
  }

  Future<void> saveUserInfo() async {
    User userData = await currentUser().then(
      (user) => User(
        userId: user.uid,
        phone: user.phoneNumber,
        name: _name,
        about: _about,
      ),
    );

    await userDataServices.createUserData(userData);
  }
}
