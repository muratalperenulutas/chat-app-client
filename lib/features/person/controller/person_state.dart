import 'package:chat_app/data/person/person.dart';

class PersonState {
  final Set<String> selectedContacts;
  final List<Person> contacts;
  final List<Person> contactsOnChatApp;
  final List<Person> contactsNotOnChatApp;

  PersonState({
    this.selectedContacts = const {},
    this.contacts = const [],
    this.contactsOnChatApp = const [],
    this.contactsNotOnChatApp = const [],
  });

  PersonState copyWith({
    Set<String>? selectedContacts,
    List<Person>? contacts,
    List<Person>? contactsOnChatApp,
    List<Person>? contactsNotOnChatApp,
  }) {
    return PersonState(
      selectedContacts: selectedContacts ?? this.selectedContacts,
      contacts: contacts ?? this.contacts,
      contactsOnChatApp: contactsOnChatApp ?? this.contactsOnChatApp,
      contactsNotOnChatApp: contactsNotOnChatApp ?? this.contactsNotOnChatApp,
    );
  }
}
