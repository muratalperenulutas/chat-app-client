import 'package:chat_app/data/contact/contact.dart';
import 'package:chat_app/data/person/person.dart';

class PersonBase {
  final String name;
  final String username;
  final String? imageId;
  final String? personId;

  PersonBase({
    required this.name,
    required this.username,
    this.imageId,
    this.personId,
  });

  factory PersonBase.fromPerson(Person person, {Contact? contact}) {
    return PersonBase(
      name: contact?.name ?? person.name ?? person.username ?? "Unknown",
      username: person.username ?? "Unknown",
      imageId: person.imageId,
      personId: person.personId,
    );
  }

  factory PersonBase.fromContact(Contact contact, {Person? person}) {
    return PersonBase(
      name: contact.name,
      username: contact.username,
      imageId: person?.imageId
      );
  }
}
