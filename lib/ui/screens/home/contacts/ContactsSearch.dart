import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/UserContacts.dart';
import 'package:whatsapp_clone/ui/screens/chat/Chat.dart';

class ContactsSearchDelegate extends SearchDelegate {
  final Future<List<ContactModel>> contacts;

  ContactsSearchDelegate(this.contacts);
  @override
  List<Widget> buildActions(BuildContext context) => null;

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<ContactModel>>(
      future: contacts.then((value) {
        return value
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (_, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/person.jpg'),
                ),
                title: Text(snapshot.data[index].name),
                subtitle: Text(snapshot.data[index].about),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Chat()),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
