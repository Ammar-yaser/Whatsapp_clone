import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final String image, name, lastMessage, date;
  final Function openChat;
  const ContactItem(
      {this.image, this.name, this.lastMessage, this.date, this.openChat});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: openChat,
            onLongPress: () {
              // TODO: delete chat
            },
            child: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(55),
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    name,
                                    style: theme.textTheme.headline6,
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    lastMessage,
                                    style: theme.textTheme.caption,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text(date),
                                // TODO: new messages counter
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 16,
              width: MediaQuery.of(context).size.width - 80,
              child: Divider(
                height: 1,
                color: Colors.grey[300],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
