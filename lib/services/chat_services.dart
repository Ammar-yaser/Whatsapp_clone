import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

class ChatServices {
  static const String chats = 'chats';

  createChat() {
    _db.collection(chats).doc().set({"contact1": "test1", "contact2": "test2"});
  }

  sendMessage() {}
}
