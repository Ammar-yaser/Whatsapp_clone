import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/blocs/providers/chat/chat_state.dart';
import 'package:whatsapp_clone/services/chat_services.dart';

class SendMessageBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChatState chatState = Provider.of<ChatState>(context);
    return Container(
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
        ),
        onTap: () {
          print('send');
          ChatServices().createChat();
          chatState.chatController.clear();
        },
      ),
    );
  }
}