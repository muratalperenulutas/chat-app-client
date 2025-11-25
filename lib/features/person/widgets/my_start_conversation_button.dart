import 'package:auto_route/auto_route.dart';
import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/router/app_router.dart';
import 'package:chat_app/data/collectivity/collectivity_repository.dart';
import 'package:chat_app/data/collectivity/dyad.dart';
import 'package:chat_app/features/chat/models/chat_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/person/person.dart';
import '../controller/person_controller.dart';

class MyStartConversationButton extends ConsumerWidget {
  final double screenHeight;
  final Person person;

  const MyStartConversationButton({
    super.key,
    required this.screenHeight,
    required this.person,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personState = ref.watch(personControllerProvider);
    final personController = ref.read(personControllerProvider.notifier);
    final collectivityRepository = getIt<CollectivityRepository>();

    bool isSelected = personState.selectedContacts.contains(person.personId);
    return MaterialButton(
      height: screenHeight / 12,
      onLongPress: () {
        if (person.isRegistered == 1 && personState.selectedContacts.isEmpty) {
          personController.addToSelectedContactsSet(person.personId);
        }
      },
      color: isSelected
          ? Color.fromARGB(254, 110, 221, 70)
          : Color.fromARGB(255, 254, 255, 255),
      onPressed: () async {
        if (personState.selectedContacts.isNotEmpty) {
          if (!isSelected) {
            personController.addToSelectedContactsSet(person.personId);
          } else {
            personController.ejectFromSelectedContactsSet(person.personId);
          }
        } else if (person.isRegistered == 1) {
          Dyad? dyad = await collectivityRepository.getDyadByUserId(person.personId ?? "");
          ChatBase chatBase;
          if (dyad == null) {
            chatBase = ChatBase.fromPerson(person);
          } else {
            chatBase = ChatBase.fromPersonAndDyad(person, dyad);
          }
          AutoRouter.of(context).push(ChatRoute(chatBase: chatBase));
        }
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
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
}
