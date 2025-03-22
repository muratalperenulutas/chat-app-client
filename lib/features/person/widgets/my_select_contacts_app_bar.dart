import 'package:chat_app/features/person/screens/create_group_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/person_controller.dart';

PersonController personController = Get.find<PersonController>();

PreferredSizeWidget MySelectContactsAppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(kToolbarHeight),
    child: Obx(() {
      if (personController.isSelectingMode()) {
        return AppBar(
          backgroundColor: Colors.purple,
          title: Text(personController.selectedContacts.length.toString()),
          actions: [
            MaterialButton(
              child: Text("New Group"),
              onPressed: () {
                Get.to(() => CreateGroupPage(
                ));
              },
            ),
          ],
        );
      } else {
        return AppBar(
          backgroundColor: Colors.amber,
          title: Text("Select Contact"),
        );
      }
    }),
  );
}
