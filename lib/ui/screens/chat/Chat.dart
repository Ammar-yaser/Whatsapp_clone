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
          ChatTextField(),
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
          // ChatTextField(),
        ],
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
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: TextField(
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
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  filled: true,
                  fillColor: Colors.white,
                ),
                minLines: 1,
                maxLines: 4,
                style: TextStyle(height: 1.5),
              ),
            ),
          ),
          SizedBox(width: 10),
          InkWell(
            child: Container(
              // height: 30,
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
        ],
      ),
    );
  }
}
