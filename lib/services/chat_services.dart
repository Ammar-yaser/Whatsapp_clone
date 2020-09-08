import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

class ChatServices {
  static const String chats = 'chats';

  createChat(String userId,String contactId) {
    _db.collection(chats).add(
      {
        'member1' : userId,
        'member2' : contactId 
      },
    ).then((value) => print(value.id));
  }

  sendMessage() {}
}
