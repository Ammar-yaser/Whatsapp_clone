import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../blocs/providers/registration/registration_state.dart';
import '../../../../blocs/providers/contacts/contacts_state.dart';
import '../../../../models/UserContacts.dart';

// Pages && widgets
import '../../../widgets/ContactItem.dart';
import '../../chat/Chat.dart';

class Contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RegistState registInfo = Provider.of<RegistState>(context, listen: false);
    ContactsState contactsState =
        Provider.of<ContactsState>(context, listen: false);
    return Container(
      child: FutureBuilder<List<UserContact>>(
        future: contactsState.chatsList(registInfo.userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error));
          } else if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                return ContactItem(
                  image: 'assets/images/person.jpg',
                  name: snapshot.data[index].name,
                  lastMessage: 'Hello chat',
                  date: '15/9/19',
                  openChat: () {
                    print(snapshot.data[index].contactId);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => Chat(),
                    //   ),
                    // );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
