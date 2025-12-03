import 'dart:async';

import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/data/contact/contact_repository.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:chat_app/data/person/person_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'person_state.dart';

part 'person_controller.g.dart';

@Riverpod(keepAlive: true)
class PersonController extends _$PersonController {
  late final PersonRepository personRepository = getIt<PersonRepository>();
  late final ContactRepository contactRepository = getIt<ContactRepository>();
  StreamSubscription? _contactsSubscription;

  @override
  PersonState build() {
    _setupListeners();
    ref.onDispose(() {
      _contactsSubscription?.cancel();
    });
    return PersonState();
  }

  void _setupListeners() {
    _contactsSubscription = contactRepository.watchContacts().listen((contacts) {
      final contactsOnChatApp = contacts.where((c) => c.personId != null).toList();
      final contactsNotOnChatApp = contacts.where((c) => c.personId == null).toList();
      
      state = state.copyWith(
        contacts: contacts,
        contactsOnChatApp: contactsOnChatApp,
        contactsNotOnChatApp: contactsNotOnChatApp,
      );
    });
  }

  void createContact(String name, String username) {
    final personService = getIt<PersonService>();
    personService.createContact(name, username);
  }


  void addToSelectedContactsSet(String? value) {
    if (value != null) {
      final newSet = Set<String>.from(state.selectedContacts)..add(value);
      state = state.copyWith(selectedContacts: newSet);
    }
  }

  void ejectFromSelectedContactsSet(String? value) {
    if (value != null) {
      final newSet = Set<String>.from(state.selectedContacts)..remove(value);
      state = state.copyWith(selectedContacts: newSet);
    }
  }

  void resetSelectedContacts() {
    state = state.copyWith(selectedContacts: {});
  }
}
