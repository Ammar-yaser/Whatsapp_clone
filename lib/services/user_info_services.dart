import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/models/User_Model.dart';

class UserDataServices {
  final Firestore _firestore = Firestore.instance;
  final String users = 'users';

  Future<void> createUserData(User user) async {
    await _firestore
        .collection(users)
        .document(user.userId)
        .setData(user.toMap());
  }

  updateUserData() {}

  deleteUserData() {}
}
