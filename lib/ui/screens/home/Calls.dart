import 'package:flutter/material.dart';

class Calls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemCount: 3,
        itemBuilder: (_, index) {
          return CallItem(
            image: 'assets/images/person.jpg',
            name: 'Ammar',
            callDate: 'July 10, 9:57 AM',
          );
        },)
    );
  }
}



class CallItem extends StatelessWidget {
  final String image, name, callDate;

  const CallItem({this.image, this.name, this.callDate});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        // ToDo: Calls info
      },
      onLongPress: () {
        // TODO: delete chat
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
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
                                    callDate,
                                    style: theme.textTheme.caption,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.call, color: theme.primaryColor, size: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
      ),
    );
  }
}
