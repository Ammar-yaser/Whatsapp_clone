import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/models/User_Model.dart';

class UserData {
  final Firestore _firestore = Firestore.instance;
  final String users = 'users';

  createUser(User user) {
    _firestore.collection(users).document(user.userId).setData({'name': 'Ammar'});
  }

  updateUser() {}

  deleteUser() {}
}
