import 'dart:async';

import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

import 'ChatAppBar.dart';

class Chat extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
          child: Column(
        children: [
          ChatAppBar(),
          Expanded(child: ChatMessages()),
          ChatMessagesFields(),
          // Emoji(),
        ],
      )),
    );
  }
}

class ChatMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: <Widget>[
          // Bubble(
          //   alignment: Alignment.center,
          //   color: Colors.white,
          //   child: Text(
          //     'Today at 5:03 PM',
          //     textAlign: TextAlign.center,
          //     style: theme.textTheme.caption,
          //   ),
          // ),
          Bubble(
            margin: BubbleEdges.only(
              left: MediaQuery.of(context).size.width * .2,
              top: 10,
            ),
            padding: const BubbleEdges.all(6),
            alignment: Alignment.topRight,
            nipWidth: 8,
            nipHeight: 10,
            nip: BubbleNip.rightTop,
            color: theme.accentColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Hello, are you nearby?',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 5),
                Text(
                  '5:28 PM',
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
          Bubble(
            margin: BubbleEdges.only(
              right: MediaQuery.of(context).size.width * .2,
              top: 10,
            ),
            padding: BubbleEdges.all(6),
            alignment: Alignment.topLeft,
            nipWidth: 8,
            nipHeight: 10,
            nip: BubbleNip.leftTop,
            color: Colors.grey[100],
            child: Text(
              'I\'ll be there in a few mins',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
        ],
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

class SendMessageBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      ),
    );
  }
}

class ChatTextField extends StatefulWidget {
  @override
  _ChatTextFieldState createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  OutlineInputBorder fieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(0),
    borderSide: BorderSide.none,
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (_) {
        // _runTimer();
      },
      onSubmitted: (_) {
        // _sendMessage();
      },
      // controller: _textEditingController,
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
