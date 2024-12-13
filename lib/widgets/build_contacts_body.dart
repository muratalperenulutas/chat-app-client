import 'package:chat_app/models/person.dart';
import 'package:chat_app/widgets/my_contacts_button.dart';
import 'package:flutter/material.dart';

Widget buildContactsBody(
    double screenHeight, Future<List<PersonModel>> contactsFuture) {
  return FutureBuilder<List<PersonModel>>(
    future: contactsFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return const Center(child: Text("Error loading contacts !"));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text("No contacts found !"));
      } else {
        final contacts = snapshot.data!;
        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return myContactsButton(context,screenHeight, contacts[index]);
                },
              ),
              SizedBox(
                height: screenHeight/20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("You have ${contacts.length} contacts.")],
                ),
              )
            ],
          ),
        );
      }
    },
  );
}
