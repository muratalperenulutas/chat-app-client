import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/data/contact/contact.dart';
import 'package:chat_app/data/contact/contact_repository.dart';
import 'package:chat_app/data/person/person.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../constants/enums/status.dart';

class PersonService {
  final PersonRepository personRepository = getIt<PersonRepository>();
  final ContactRepository contactRepository = getIt<ContactRepository>();

  PersonService();

  Future<void> createContact(String name, String username) async {
    debugPrint("name:$name  username:$username");
    
    Contact? existingContact = await contactRepository.findByUsername(username);
    
    if (existingContact != null) {
      Contact updatedContact = Contact(
        id: existingContact.id,
        name: name,
        username: username,
      );
      await contactRepository.updateContact(updatedContact);
    } else {
      Contact newContact = Contact(
        name: name,
        username: username,
      );
      await contactRepository.insertContact(newContact);
    }
  }

  Future<void> fetchPerson(Person person) async {
    try {
      final existingPerson = await personRepository.findPersonByUsernameOrUserId(person.username ?? '', person.personId ?? "");

      if (existingPerson != null) {
        Person personModel = Person(
            name: person.name,
            personId: person.personId,
            description: person.description,
            imageId: person.imageId,
            username: person.username,
            id: existingPerson.id,
            status: Status.sync);
        await personRepository.updatePerson(personModel);
      } else {
        person.status = Status.sync;
        await personRepository.insertPerson(person);
      }
      
      if (person.username != null) {
        Contact? contact = await contactRepository.findByUsername(person.username!);
        if (contact != null) {
           Contact updatedContact = Contact(
            id: contact.id,
            name: contact.name,
            username: contact.username,
            status: Status.sync
          );
          await contactRepository.updateContact(updatedContact);
        }
      }
    } catch (e) {
      debugPrint("Error inserting person: $e");
    }
  }
}
