
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../collectivity/controller/collectivity_controller.dart';
import 'my_conversation_button.dart';

Widget buildChatsBody(double screenHeight) {
  CollectivityController collectivityController = Get.find<CollectivityController>();

  return Obx(() {
    final chatBaseModels = collectivityController.chatBaseModels;

    if (chatBaseModels.isEmpty) {
      return const Center(child: Text("No groups found !"));
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: chatBaseModels.length,
            itemBuilder: (context, index) {
              return myConversationButton(context, screenHeight,chatBaseModels[index]);
            },
          ),
          SizedBox(
            height: screenHeight / 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("You have ${chatBaseModels.length} collectivity.")],
            ),
          ),
        ],
      ),
    );
  });
}
