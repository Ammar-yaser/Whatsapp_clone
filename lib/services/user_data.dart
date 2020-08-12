import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final Firestore _firestore = Firestore.instance;
  final String users = 'users';

  createUser() {
    _firestore.collection(users).document().setData({'name': 'Ammar'});
  }
}
