import 'package:auto_route/auto_route.dart';
import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/router/app_router.dart';
import 'package:chat_app/data/collectivity/collectivity_repository.dart';
import 'package:chat_app/data/collectivity/dyad.dart';
import 'package:chat_app/data/person/person.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:chat_app/features/chat/models/chat_base.dart';
import 'package:chat_app/features/person/models/person_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/person_controller.dart';

class MyStartConversationButton extends ConsumerWidget {
  final double screenHeight;
  final PersonBase personBase;

  const MyStartConversationButton({
    super.key,
    required this.screenHeight,
    required this.personBase,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personState = ref.watch(personControllerProvider);
    final personController = ref.read(personControllerProvider.notifier);
    final collectivityRepository = getIt<CollectivityRepository>();
    final personRepository = getIt<PersonRepository>();

    bool isSelected = personState.selectedContacts.contains(personBase.personId);
    return MaterialButton(
      height: screenHeight / 12,
      onLongPress: () {
        if (personBase.personId != null && personState.selectedContacts.isEmpty) {
          personController.addToSelectedContactsSet(personBase.personId);
        }
      },
      color: isSelected
          ? Color.fromARGB(254, 110, 221, 70)
          : Color.fromARGB(255, 254, 255, 255),
      onPressed: () async {
        if (personState.selectedContacts.isNotEmpty) {
          if (!isSelected) {
            personController.addToSelectedContactsSet(personBase.personId);
          } else {
            personController.ejectFromSelectedContactsSet(personBase.personId);
          }
        } else if (personBase.personId != null) {
          Dyad? dyad = await collectivityRepository.getDyadByUserId(personBase.personId ?? "");
          Person? person = await personRepository.findPersonByPersonId(personBase.personId!);
          
          if(person != null){
             ChatBase chatBase;
            if (dyad == null) {
              chatBase = ChatBase.fromPerson(person, nameOverride: personBase.name);
            } else {
              chatBase = ChatBase.fromPersonAndDyad(person, dyad, nameOverride: personBase.name);
            }
            AutoRouter.of(context).push(ChatRoute(chatBase: chatBase));
          }
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
                  personBase.name,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  personBase.username,
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
