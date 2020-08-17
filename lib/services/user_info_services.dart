import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/User_Model.dart';

class UserDataServices {
  final Firestore _firestore = Firestore.instance;
  final String users = 'users';

  Future<void> createUserData(User user) async {
    try {
      await _firestore
          .collection(users)
          .document(user.userId)
          .setData(user.toMap());
    } catch (e) {
      print(e.code);
    }
  }

  updateUserData() {}

  deleteUserData() {}
}
