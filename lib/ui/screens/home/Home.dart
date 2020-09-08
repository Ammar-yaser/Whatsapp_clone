import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/blocs/providers/contacts/contacts_state.dart';
import 'package:whatsapp_clone/blocs/providers/registration/registration_state.dart';
import 'package:whatsapp_clone/ui/screens/registration/Registration.dart';

// Pages
import 'Calls.dart';
import 'contacts/Contacts.dart';
import 'status_page/Status.dart';
import 'contacts/ContactsSearch.dart';

class Home extends StatelessWidget {
  static const String id = "home";
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => ContactsState(),
        ),
      ],
      child: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ContactsState contactsState =
        Provider.of<ContactsState>(context, listen: false);
    RegistState registState = Provider.of<RegistState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              var searchList = contactsState.availableUsersFromContacts();
              showSearch(
                context: context,
                delegate: ContactsSearchDelegate(searchList),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              registState.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (_) => Registration()),
                  (route) => false);
            },
          ),
          // PopupMenuButton(
          //   itemBuilder: (BuildContext context) {
          //     return [
          //       PopupMenuItem(
          //         child: Text('New group'),
          //       ),
          //       PopupMenuItem(
          //         child: Text('New broadcast'),
          //       ),
          //       PopupMenuItem(
          //         child: Text('Settings'),
          //       ),
          //     ];
          //   },
          // ),
        ],
        // flexibleSpace: SafeArea(child: SearchBar()),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorPadding: EdgeInsets.zero,
          tabs: [
            Tab(text: 'Chats'.toUpperCase()),
            Tab(text: 'Status'.toUpperCase()),
            Tab(text: 'Calls'.toUpperCase()),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Contacts(),
          Status(),
          Calls(),
          // Status(),
          // Calls(),
        ],
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
