

import 'package:cloud_firestore/cloud_firestore.dart';

Firestore _db = Firestore.instance;

class ChatServices {
  static const String chats = 'chats';

  createChat() {
    _db.collection(chats).document().setData(
      {
        "contact1" : "test1",
        "contact2" : "test2"
      }
    );
  }

  sendMessage() {

  }



}