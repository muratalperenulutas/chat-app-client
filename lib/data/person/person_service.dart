import 'package:chat_app/data/person/person.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:get/get.dart';

import '../../constants/enums/source_enum.dart';
import '../../constants/enums/status.dart';

class PersonService extends GetxService {
  PersonRepository personRepository=Get.find<PersonRepository>();

  Future<void> createContact(String name,String username)async {
    PersonModel? existingPerson=await personRepository.findPersonByUsername(username);
    if(existingPerson!=null){
      existingPerson.setLocalName(name);
      personRepository.updatePerson(existingPerson);
    }else {
      PersonModel person = PersonModel(
          localName: name,
          username: username,
          source: SourceEnum.LOCAL,
      isRegistered: 0);
      personRepository.insertPerson(person);
    }
  }

  Future<void> fetchPerson(PersonModel person) async {
    try {
      final existingPerson = await personRepository.findPersonByUsernameOrUserId(person.username ?? '',person.personId??"");

      if (existingPerson != null) {

        PersonModel personModel = PersonModel(
            name: person.name,
            source: existingPerson.source,
            personId: person.personId,
            isRegistered: 1,
            description: person.description,
            imageId: person.imageId,
            localName: existingPerson.localName,
            username: person.username,
            id: existingPerson.id,
            status: Status.SYNC);
        personRepository.updatePerson(personModel);
      } else {
        person.source=SourceEnum.SERVER;
        person.status=Status.SYNC;
        personRepository.insertPerson(person);
      }
    } catch (e) {
      print("Error inserting person: $e");
    }
  }
}
