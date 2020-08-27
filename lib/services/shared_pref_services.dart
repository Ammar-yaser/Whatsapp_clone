import 'package:shared_preferences/shared_preferences.dart';
import '../models/User_Model.dart';

class SharedPrefServices {
  static const String _id = 'userId';
  static const String _mobile = 'mobile';
  static const String _remember = 'remember';
  
  Future<void> setLocalUserData(User userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isIdSaved = await prefs.setString(_id, userData.userId);
    bool isMobileSaved = await prefs.setString(_mobile, userData.mobile);

    if (isIdSaved && isMobileSaved) {
      await prefs.setBool(_remember, true);
    }
  }

  Future<bool> isRemembered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_remember);
  }
  
  Future<String> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_id);
  }
}
