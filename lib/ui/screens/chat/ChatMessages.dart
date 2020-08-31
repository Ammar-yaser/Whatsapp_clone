import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

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