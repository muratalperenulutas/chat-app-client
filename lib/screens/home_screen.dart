import 'package:chat_app/widgets/my_bottom_navigation_app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(children: [
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return MaterialButton(
                      height: screenHeight / 12,
                      color: Color.fromARGB(255, 254, 255, 255),
                      onPressed: () {},
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 65,
                              height: 65,
                              child: const CircleAvatar(
                                radius: 32.5,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(
                                        "") //NetworkImage()                            ),
                                    ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Column(
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "text",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 85, 92, 94)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
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
        title: Text("Chat App " + screenWidth.toString()),
      ),
    );
  }
}
