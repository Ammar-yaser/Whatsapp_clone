import 'package:shared_preferences/shared_preferences.dart';
import '../models/User_Model.dart';

/*
    NOTE: This file is not required for what I want to do because I have a firebase current user I can use it. so this file for just practicing a lot of functions from shared pref 
*/

class SharedPrefServices {
  static const String _id = 'userId';
  static const String _mobile = 'mobile';
  static const String _remember = 'remember';

  Future<void> setLocalUserData({UserModel userData, bool isRemembered}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (userData == null) {
      await prefs.setBool(_remember, isRemembered);
    } else {
      bool isIdSaved = await prefs.setString(_id, userData.userId);
      bool isMobileSaved = await prefs.setString(_mobile, userData.mobile);
      if (isIdSaved && isMobileSaved) {
        await prefs.setBool(_remember, isRemembered);
      }
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
