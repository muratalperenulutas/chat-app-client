
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../collectivity/controller/collectivity_controller.dart';
import 'my_conversation_button.dart';

Widget buildChatsBody(double screenHeight) {
  return Consumer(
    builder: (context, ref, child) {
      final collectivityState = ref.watch(collectivityControllerProvider);
      final chatBaseModels = collectivityState.chatBaseModels;

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
                return myConversationButton(context, screenHeight, chatBaseModels[index]);
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
    },
  );
}
