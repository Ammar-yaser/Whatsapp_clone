import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../models/UserContacts.dart';

class ChatState with ChangeNotifier {
  TextEditingController _controller;
  UserContact contactData;

  set setController(TextEditingController value) => _controller = value;
  TextEditingController get chatController => _controller;






}