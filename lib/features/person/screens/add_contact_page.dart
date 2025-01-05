import 'package:chat_app/features/person/controller/person_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class addContactsPage extends StatefulWidget {
  const addContactsPage({super.key});

  @override
  State<addContactsPage> createState() => _addContactsPageState();
}

class _addContactsPageState extends State<addContactsPage> {
  final _surnameController = TextEditingController();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  PersonController personController=Get.find<PersonController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Center(child: Text("New Contact")),
          actions: [
            IconButton(
                onPressed: () async {
                  personController.createContact("${_nameController.text} ${_surnameController.text}", _usernameController.text);
                  Get.back();
                },
                icon: const Icon(Icons.check))
          ],
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            height: screenHeight * 0.80,
            width: screenWidth * 0.80,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                        width: screenWidth * 0.15,
                        child: const Icon(Icons.badge)),
                    SizedBox(
                      width: screenWidth * 0.65,
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            hintText: "Name",
                            labelStyle: TextStyle(color: Colors.black),
                            border: UnderlineInputBorder()),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.15,
                    ),
                    SizedBox(
                      width: screenWidth * 0.65,
                      child: TextField(
                        controller: _surnameController,
                        decoration: const InputDecoration(
                            hintText: "Surname",
                            labelStyle: TextStyle(color: Colors.black),
                            border: UnderlineInputBorder()),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: screenWidth * 0.15,
                        child: const Icon(Icons.alternate_email)),
                    SizedBox(
                      width: screenWidth * 0.65,
                      child: TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          hintText: "Username",
                          labelStyle: TextStyle(color: Colors.black),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
