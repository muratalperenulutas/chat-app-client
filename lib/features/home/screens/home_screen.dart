import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../collectivity/widgets/build_chats_body.dart';
import '../../person/widgets/build_contacts_body.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/my_navigation_app_bar.dart';
import '../widgets/my_floating_action_button.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
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
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedIndex = _tabController.index;
        });
      }
    });
  }

  List<MyNavigationBarItem> get navBarItems => [
        MyNavigationBarItem(title: "Home", icon: Icons.home_outlined),
        MyNavigationBarItem(title: "Chats", icon: Icons.chat_sharp),
        MyNavigationBarItem(
            title: "Contacts", icon: Icons.perm_contact_cal_sharp),
        MyNavigationBarItem(title: "Me", icon: Icons.account_circle),
      ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isWideScreen = screenWidth > 600;

    List<Widget> widgetOptions = <Widget>[
      const Center(child: Text("Home Page")),
      buildChatsBody(screenHeight),
      buildContactsBody(screenHeight),
      const Center(child: Text("Me Page"))
    ];
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isWideScreen)
            MyNavigationBar(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                items: navBarItems,
                onTab: _onItemTapped,
                currentIndex: _selectedIndex,
                position: NavigationBarPosition.left),
          Expanded(
            child: Column(
              children: [
                if (!isWideScreen)
                  buildAppBar(screenHeight, isWideScreen, context),
                Expanded(
                  child: TabBarView(
                      controller: _tabController, children: widgetOptions),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: myFloatingActionButton(context, _selectedIndex),
      bottomNavigationBar: !isWideScreen
          ? MyNavigationBar(
              position: NavigationBarPosition.bottom,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              currentIndex: _selectedIndex,
              items: navBarItems,
              onTab: _onItemTapped,
            )
          : null,
    );
  }
}
