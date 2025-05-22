import 'package:chat_app/data/collectivity/collectivity_repository.dart';
import 'package:chat_app/data/collectivity/dyad.dart';
import 'package:chat_app/features/chat/models/chat_base.dart';
import 'package:chat_app/features/chat/screens/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/person/person.dart';
import '../controller/person_controller.dart';

MaterialButton myStartConversationButton(
    double screenHeight, Person person) {
  PersonController personController = Get.find<PersonController>();
  bool isSelected = personController.isInSelectedContactsSet(person.personId);
  print("a");
  return MaterialButton(
    height: screenHeight / 12,
    onLongPress: () {
      if (person.isRegistered == 1 &&
          !personController.isSelectingMode()) {
        personController.addToSelectedContactsSet(person.personId);
      }
    },
    color: isSelected
        ? Color.fromARGB(254, 110, 221, 70)
        : Color.fromARGB(255, 254, 255, 255),
    onPressed: () async {
      if (personController.isSelectingMode()) {
        if (!isSelected) {
          personController.addToSelectedContactsSet(person.personId);
        } else {
          personController.ejectFromSelectedContactsSet(person.personId);
        }
      } else if (person.isRegistered == 1) {
        Dyad? dyad = await Get.find<CollectivityRepository>()
            .getDyadByUserId(person.personId ?? "");
        ChatBase chatBase;
        if (dyad == null) {
          chatBase = ChatBase.fromPerson(person);
        } else {
          chatBase = ChatBase.fromPersonAndDyad(person, dyad);
        }
        Get.to(() => ChatPage(
              chatBase: chatBase,
            ));
      }
    },
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
                  backgroundImage: AssetImage('assets/images/murat.png')),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(
                person.localName ?? "",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                person.description ?? "",
                style: TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 85, 92, 94)),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
