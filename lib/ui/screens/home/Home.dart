import 'package:flutter/material.dart';

// Pages
import 'Calls.dart';
import 'Contacts.dart';
import 'status_page/Status.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // _tabController.addListener(_isProductsPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('New group'),
                ),
                PopupMenuItem(
                  child: Text('New broadcast'),
                ),
                PopupMenuItem(
                  child: Text('Settings'),
                ),
              ];
            },
          ),
        ],
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
