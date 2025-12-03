import 'package:chat_app/data/contact/contact.dart';

class PersonState {
  final Set<String> selectedContacts;
  final List<Contact> contacts;
  final List<Contact> contactsOnChatApp;
  final List<Contact> contactsNotOnChatApp;

  PersonState({
    this.selectedContacts = const {},
    this.contacts = const [],
    this.contactsOnChatApp = const [],
    this.contactsNotOnChatApp = const [],
  });

  PersonState copyWith({
    Set<String>? selectedContacts,
    List<Contact>? contacts,
    List<Contact>? contactsOnChatApp,
    List<Contact>? contactsNotOnChatApp,
  }) {
    return PersonState(
      selectedContacts: selectedContacts ?? this.selectedContacts,
      contacts: contacts ?? this.contacts,
      contactsOnChatApp: contactsOnChatApp ?? this.contactsOnChatApp,
      contactsNotOnChatApp: contactsNotOnChatApp ?? this.contactsNotOnChatApp,
    );
  }
}
