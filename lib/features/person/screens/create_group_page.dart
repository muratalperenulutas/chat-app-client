import 'package:chat_app/core/services/ingest/collectivity_ingest.dart';
import 'package:chat_app/features/person/controller/person_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  PersonController personController = Get.find<PersonController>();
  CollectivityIngest collectivityIngest = Get.find<CollectivityIngest>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("New Group"),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          IconButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  collectivityIngest.createGroup(_nameController.text,
                      personController.selectedContacts.toList());
                  Get.offAllNamed("/home");
                }
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
                hintText: "Name",
                labelStyle: TextStyle(color: Colors.black),
                border: UnderlineInputBorder()),
          )
        ],
      ),
    );
  }
}
