import 'package:chat_app/data/person/person.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:get/get.dart';

import '../../constants/enums/source_enum.dart';
import '../../constants/enums/status.dart';

class PersonService extends GetxService {
  PersonRepository personRepository=Get.find<PersonRepository>();

  Future<void> createContact(String name,String username)async {
    print("name:$name  username:$username");
    Person? existingPerson=await personRepository.findPersonByUsername(username);
    if(existingPerson!=null){
      print(existingPerson);
      existingPerson.setLocalName(name);
      existingPerson.setSource(SourceEnum.LOCAL);
      personRepository.updatePerson(existingPerson);
    }else {
      Person person = Person(
          localName: name,
          username: username,
          source: SourceEnum.LOCAL,
      isRegistered: 0);
      personRepository.insertPerson(person);
    }
  }

  Future<void> fetchPerson(Person person) async {
    try {
      final existingPerson = await personRepository.findPersonByUsernameOrUserId(person.username ?? '',person.personId??"");

      if (existingPerson != null) {

        Person personModel = Person(
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
