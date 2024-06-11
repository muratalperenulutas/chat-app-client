import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      bottomNavigationBar: BottomAppBar(
        //varsayılan padding problemi
        color: Colors.green,
        padding: EdgeInsets.all(0),
        height: screenHeight / 14,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  onPressed: () {},
                  child: const Column(
                    children: [
                      Icon(
                        Icons.home_outlined,
                        size: 25.0,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text("Home"),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: const Column(
                    children: [
                      Icon(
                        Icons.chat_sharp,
                        size: 25.0,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text("Chats"),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: const Column(
                    children: [
                      Icon(
                        Icons.perm_contact_cal_sharp,
                        size: 25.0,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text("Contacts"),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: const Column(
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 25.0,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text("Me"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
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
