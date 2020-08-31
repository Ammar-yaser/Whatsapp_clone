import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/blocs/providers/chat/chat_state.dart';
import 'package:whatsapp_clone/models/UserContacts.dart';
import 'package:whatsapp_clone/ui/screens/chat/ChatTextField.dart';

import 'ChatAppBar.dart';
import 'ChatMessages.dart';
import 'ChatSendBtn.dart';

class Chat extends StatelessWidget {
  final UserContact contactData;

  const Chat({this.contactData});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatState>(
      create: (_) => ChatState(),
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Container(
          child: Column(
            children: [
              ChatAppBar(name: contactData.name),
              Expanded(child: ChatMessages()),
              ChatMessagesFields(),
              // Emoji(),
            ],
          ),
        ),
      ),
    );
  }
}


class ChatMessagesFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  Icon(
                    Icons.face,
                    color: Colors.grey[500],
                  ),
                  Expanded(
                    child: ChatTextField(),
                  ),
                  Icon(
                    Icons.attach_file,
                    color: Colors.grey[500],
                  ),
                  SizedBox(width: 18),
                  Icon(
                    Icons.camera_alt,
                    color: Colors.grey[500],
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 6),
          SendMessageBtn(),
        ],
      ),
    );
  }
}


class Emoji extends StatefulWidget {
  @override
  _EmojiState createState() => _EmojiState();
}

class _EmojiState extends State<Emoji> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: EmojiPicker(
        rows: 3,
        columns: 7,
        recommendKeywords: ["racing", "horse"],
        numRecommended: 10,
        onEmojiSelected: (emoji, category) {
          print(emoji);
        },
      ),
    );
  }
}
