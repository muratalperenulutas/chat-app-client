import 'package:chat_app/models/group.dart';
import 'package:chat_app/widgets/my_conversation_button.dart';
import 'package:flutter/material.dart';

Widget buildChatsBody(
    double screenHeight, Future<List<GroupModel>> groupsFuture) {
  return FutureBuilder<List<GroupModel>>(
    future: groupsFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return const Center(child: Text("Error loading groups !"));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text("No groups found !"));
      } else {
        final groups = snapshot.data!;
        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  return myConversationButton(screenHeight, groups[index]);
                },
              )
            ],
          ),
        );
      }
    },
  );
}
