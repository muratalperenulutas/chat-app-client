import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/widgets/build_chats_body.dart';
import 'package:chat_app/widgets/my_bottom_navigation_app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with TickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

    @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<Widget> widgetOptions = <Widget>[
      const Center(child: Text("Home Page")),
      const Center(child: Text("Chats Page")),
      const Center(child: Text("Contacts Page")),
      const Center(child: Text("Me Page"))
    ];
    return Scaffold(
      body: TabBarView(controller: _tabController, children: widgetOptions),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.message),
        backgroundColor: Colors.green,
      ),
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        backgroundColor: Colors.green,
        toolbarHeight: screenHeight / 16,
        title: Text("Chat App "),actions: [
        IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: ((context) => const LoginPage()),
                ),
              );
            },
            icon: const Icon(Icons.logout))
      ],
      ),
    );
  }
}
