import 'package:chat_app/data/collectivity/collectivity_abstract.dart';
import 'package:chat_app/data/collectivity/dyad.dart';
import 'package:chat_app/data/contact/contact.dart';
import 'package:chat_app/data/contact/contact_repository.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:chat_app/core/di/injection.dart';
import 'package:flutter/material.dart';

import '../../../data/collectivity/group.dart';
import '../../../data/person/person.dart';

class ChatBase {
  late String? collectivityId;
  final String? name;
  final String? creatorId;
  final String? imageId;
  final String? personId;

  ChatBase(
      {this.collectivityId,
      this.name,
      this.creatorId,
      this.imageId,
      this.personId,});

  factory ChatBase.fromPerson(Person person, {String? nameOverride}) {
    return ChatBase(
        name: nameOverride ?? person.username,
        imageId: person.imageId,
        personId: person.personId,);
  }
  factory ChatBase.fromPersonAndDyad(Person person,Dyad dyad, {String? nameOverride}) {
    return ChatBase(
      collectivityId: dyad.collectivityId,
        name: nameOverride ?? person.username,
        imageId: person.imageId,
        personId: person.personId,);
  }

  factory ChatBase.fromGroup(Group group) {
    return ChatBase(
        name: group.name,
        creatorId: group.creatorId,
        imageId: group.imageId,
        collectivityId: group.collectivityId,);
  }

   static Future<List<ChatBase>> fromCollectivities(List<Collectivity> collectivities) async {
    List<ChatBase> chatBaseModels=<ChatBase>[];
    final personRepository = getIt<PersonRepository>();
    final contactRepository = getIt<ContactRepository>();

    for(Collectivity collectivity in collectivities) {
      if (collectivity is Group) {
        chatBaseModels.add(ChatBase.fromGroup(collectivity));
      } else if (collectivity is Dyad) {
          Person? person = await personRepository
              .findPersonByPersonId(collectivity.userId);
          if(person!=null) {
            Contact? contact;
            if (person.personId != null) {
              contact = await contactRepository.findContactByPersonId(person.personId!);
            }
            chatBaseModels.add(
                ChatBase.fromPersonAndDyad(
                    person, collectivity, nameOverride: contact?.name));
          }
          debugPrint(person==null?"person model null":"");
      } else {
        debugPrint("Error: Invalid condition.$collectivity");
        throw Error();
      }
    }
    return chatBaseModels;
  }
}
