import 'package:flutter/material.dart';

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