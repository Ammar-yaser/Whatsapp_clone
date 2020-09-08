import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../blocs/providers/chat/chat_state.dart';

class ChatTextField extends StatefulWidget {
  @override
  _ChatTextFieldState createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  TextEditingController chatFieldController = TextEditingController();
  OutlineInputBorder fieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(0),
    borderSide: BorderSide.none,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ChatState chatState = Provider.of<ChatState>(context);
    chatState.setController = chatFieldController;
  }

  @override
  Widget build(BuildContext context) {
    ChatState chatState = Provider.of<ChatState>(context);
    return TextField(
      controller: chatFieldController,
      onChanged: (val) {
        // _runTimer();
        chatState.showMic = val == '';
        chatState.setMessage = val;
        print('val: $val');
      },
      onSubmitted: (_) {
        // _sendMessage();
      },
      decoration: InputDecoration(
        isDense: true,
        hintText: 'Type a message...',
        enabledBorder: fieldBorder,
        focusedBorder: fieldBorder,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 11),
        filled: true,
        fillColor: Colors.white,
      ),
      minLines: 1,
      maxLines: 4,
      style: TextStyle(height: 1.6),
    );
  }
}
