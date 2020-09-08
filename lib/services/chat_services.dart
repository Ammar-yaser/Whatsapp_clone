import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Message.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

class ChatServices {
  static const String chats = 'chats';
  static const String messages = 'messages';

  Future<String> createChat(String userId, String contactId) async {
    String chatId = await _db.collection(chats).add(
      {'member1': userId, 'member2': contactId},
    ).then((value) => value.id);

    return chatId;
  }

  Future<void> sendMessage(String chatId, Message message) async {
    _db.collection(chats).doc(chatId).collection(messages).add(message.toMap());
  }
}
