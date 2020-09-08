import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../../models/Message.dart';
import '../../../services/contacts_services.dart';
import '../../../services/chat_services.dart';
import '../../../models/UserContacts.dart';

final ChatServices chatServices = ChatServices();
final ContactsServices contactsServices = ContactsServices();

class ChatState with ChangeNotifier {
  TextEditingController _controller;
  UserContact contactData;
  String _message;
  bool _showMic = true;
  bool _isChatExist = false;

  ChatState(this.contactData);

  set setController(TextEditingController value) => _controller = value;
  TextEditingController get chatController => _controller;

  set setMessage(String val) {
    _message = val;
  }

  set isChatExist(bool val) {
    _isChatExist = val;
    notifyListeners();
  }

  set showMic(bool val) {
    _showMic = val;
    notifyListeners();
  }

  bool get showMic => _showMic;
  bool get isChatExist => _isChatExist;

  Future<void> createChatId(String userId) async {
    String chatId =
        await chatServices.createChat(userId, contactData.contactId);
    contactData.chatId = chatId;
    contactsServices.saveContact(userId, contactData);
  }

  Future<void> sendMessage(String sendby, Timestamp time) async {
    if (_isChatExist == true) {
      Message message = Message(message: _message, sentby: sendby, time: time);
      await chatServices.sendMessage(contactData.chatId, message);
    } else {
      createChatId(sendby).then((_) {
        _isChatExist = true;
        sendMessage(sendby, time);
      });
    }
  }
}
