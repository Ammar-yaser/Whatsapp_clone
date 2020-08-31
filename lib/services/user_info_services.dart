import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/User_Model.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

class UserDataServices {
  final String users = 'users';

  Future<void> createUserData(UserModel user) async {
    try {
      await _db
          .collection(users)
          .doc(user.userId)
          .set(user.toMap());
    } catch (e) {
      print(e.code);
    }
  }

  updateUserData() {}

  deleteUserData() {}
}
