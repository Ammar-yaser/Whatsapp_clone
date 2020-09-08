import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../blocs/providers/chat/chat_state.dart';
import '../../../blocs/providers/registration/registration_state.dart';

class SendMessageBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChatState chatState = Provider.of<ChatState>(context, listen: false);
    RegistState registState = Provider.of<RegistState>(context, listen: false);
    return Container(
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(
            Icons.send, //chatState.showMic ? Icons.mic : Icons.send,
            color: Colors.white,
          ),
        ),
        onTap: () {
          chatState.chatController.clear();
          chatState.sendMessage(registState.userId, Timestamp.now());
        },
      ),
    );
  }
}
