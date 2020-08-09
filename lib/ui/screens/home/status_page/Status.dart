import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      color: Colors.grey[300],
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: MyStatus()),
        ],
      ),
    );
  }
}

class MyStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(55),
                  image: DecorationImage(
                    image: AssetImage('assets/images/person.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: -1,
                right: -1,
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 10,
                  child: Icon(Icons.add, color: Colors.white, size: 20),
                ),
              )
            ],
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'My status',
                            style: theme.textTheme.headline6,
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Tap to add status update',
                            style: theme.textTheme.caption,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
