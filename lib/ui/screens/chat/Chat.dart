import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          ChatAppBar(),
          ChatMessages(),
        ],
      )),
    );
  }
}

class ChatAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(bottom: 6, left: 5, top: 8),
      color: theme.primaryColor,
      child: SafeArea(
        child: Container(
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.arrow_back, color: Colors.white),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          image: DecorationImage(
                            image: AssetImage('assets/images/person.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  child: Text(
                    'Ammar',
                    style:
                        theme.textTheme.headline6.copyWith(color: Colors.white),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.videocam, color: Colors.white),
                onPressed: () {
                  //TODO: make video call
                },
              ),
              IconButton(
                icon: Icon(Icons.phone, color: Colors.white),
                onPressed: () {
                  //TODO: make phone call
                },
              ),
              // TODO: popup menu for every user chat
            ],
          ),
        ),
      ),
    );
  }
}

class ChatMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      child: Column(
        children: <Widget>[
          Bubble(
            alignment: Alignment.center,
            color: Colors.white,
            child: Text(
              'Today at 5:03 PM',
              textAlign: TextAlign.center,
              style: theme.textTheme.caption,
            ),
          ),
          Bubble(
            margin: BubbleEdges.only(
                left: MediaQuery.of(context).size.width * .2, top: 10),
            padding: BubbleEdges.all(12),
            alignment: Alignment.topRight,
            radius: Radius.circular(13),
            nipWidth: 10,
            nipHeight: 10,
            nip: BubbleNip.rightBottom,
            color: theme.primaryColor,
            child: Text(
              'Hello, are you nearby?',
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.right,
            ),
          ),
          Bubble(
            margin: BubbleEdges.only(
                right: MediaQuery.of(context).size.width * .2, top: 10),
            padding: BubbleEdges.all(12),
            alignment: Alignment.topLeft,
            radius: Radius.circular(13),
            nipWidth: 10,
            nipHeight: 10,
            nip: BubbleNip.leftBottom,
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
      color: Colors.grey[100].withOpacity(0.8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 10, 25),
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
                          EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      filled: true,
                      fillColor: Colors.white),
                  minLines: 1,
                  maxLines: 4,
                  style: TextStyle(height: 1.5),
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.send),
                color: Theme.of(context).primaryColor,
                iconSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
