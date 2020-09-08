import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../../services/chat_services.dart';
import '../../../models/UserContacts.dart';

final ChatServices chatServices = ChatServices();

class ChatState with ChangeNotifier {
  TextEditingController _controller;
  UserContact contactData;
  bool _showMic = true;
  ChatState(this.contactData);

  set setController(TextEditingController value) => _controller = value;
  TextEditingController get chatController => _controller;

  set showMic(bool val) {
    _showMic = val;
    notifyListeners();
  }
  bool get showMic => _showMic;

  createChatonDb(String userId) {
    chatServices.createChat(userId, contactData.contactId);
  }
}
