
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../group/controller/group_controller.dart';
import 'my_conversation_button.dart';

Widget buildChatsBody(double screenHeight) {
  GroupController groupController = Get.find<GroupController>();

  return Obx(() {
    final groups = groupController.groups;

    if (groups.isEmpty) {
      return const Center(child: Text("No groups found !"));;
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: groups.length,
            itemBuilder: (context, index) {
              return myConversationButton(context, screenHeight, groups[index]);
            },
          ),
          SizedBox(
            height: screenHeight / 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("You have ${groups.length} groups.")],
            ),
          ),
        ],
      ),
    );
  });
}
