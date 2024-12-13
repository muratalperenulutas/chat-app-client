import 'dart:ffi';

import 'package:chat_app/models/group.dart';
import 'package:chat_app/models/person.dart';
import 'package:chat_app/services/database/database.dart';
import 'package:chat_app/services/websocket/websocket.dart';
import 'package:chat_app/widgets/build_chats_body.dart';
import 'package:chat_app/widgets/build_contacts_body.dart';
import 'package:chat_app/widgets/my_app_bar.dart';
import 'package:chat_app/widgets/my_bottom_navigation_app_bar.dart';
import 'package:chat_app/widgets/my_floating_action_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<GroupModel>> _groupsFuture;
  late Future<List<PersonModel>> _contactsFuture;
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
     _tabController.index = _selectedIndex;
  }

    @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener((){
      if(!_tabController.indexIsChanging){
        setState(() {
          _selectedIndex=_tabController.index;
        });
      }
    }

    );
    _groupsFuture =DatabaseManager.getGroups();
    _contactsFuture=DatabaseManager.getContacts();
    WebSocketClient();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<Widget> widgetOptions = <Widget>[
      const Center(child: Text("Home Page")),
      buildChatsBody(screenHeight,_groupsFuture),
      buildContactsBody(screenHeight, _contactsFuture),
      const Center(child: Text("Me Page"))
    ];
    return Scaffold(
      body: TabBarView(controller: _tabController, children: widgetOptions),
      floatingActionButton: myFloatingActionButton(context,_selectedIndex),
      bottomNavigationBar: MyBottomNavigationBar(
        screenHeight: screenHeight,
        currentIndex: _selectedIndex,
        items: [
          MyBottomNavigationBarItem(title: "Home", icon: Icons.home_outlined),
          MyBottomNavigationBarItem(title: "Chats", icon: Icons.chat_sharp),
          MyBottomNavigationBarItem(
              title: "Contacts", icon: Icons.perm_contact_cal_sharp),
          MyBottomNavigationBarItem(title: "Me", icon: Icons.account_circle),
        ],
        onTab: _onItemTapped,
      ),
      appBar: buildAppBar(screenHeight, context)
    );
  }
}
