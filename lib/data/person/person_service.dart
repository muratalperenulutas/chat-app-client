import 'package:chat_app/data/person/person.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:get/get.dart';

import '../../constants/enums/source_enum.dart';

class PersonService extends GetxService {
  PersonRepository personRepository=Get.find<PersonRepository>();

  Future<void> createContact(String name,String username)async {
    PersonModel person = PersonModel(
        localName: name,
        username: username,
        source: SourceEnum.LOCAL,
        isRegistered: 0);
    personRepository.insertPerson(person);
  }

  Future<void> fetchPersonFromServer(PersonModel person) async {
    try {
      final existingPerson = await personRepository.findPersonByUsername(person.username ?? '');
      if (existingPerson != null) {

        PersonModel personModel = PersonModel(
            name: person.name,
            source: existingPerson.source,
            personId: person.personId,
            isSynced: 1,
            isRegistered: 1,
            description: person.description,
            imageId: person.imageId,
            localName: existingPerson.localName,
            username: existingPerson.username,
            id: existingPerson.id);
        personRepository.updatePerson(personModel, existingPerson.id??0);
      } else {
        personRepository.insertPerson(person);
      }
    } catch (e) {
      print("Error inserting person: $e");
    }
  }
}
