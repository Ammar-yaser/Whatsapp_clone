import 'package:flutter/material.dart';

// Pages && widgets
import '../../widgets/ContactItem.dart';

class Contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemCount: 16,
        itemBuilder: (_, index) {
          return ContactItem(
            image: 'assets/images/person.jpg',
            name: 'Ammar',
            lastMessage: 'Hello chat',
            date: '15/9/19',
          );
        },
      ),
    );
  }
}
