import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/general_change_notifier.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:chat_app/data/person/person_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'person_state.dart';

part 'person_controller.g.dart';

@Riverpod(keepAlive: true)
class PersonController extends _$PersonController {
  late final PersonRepository personRepository = getIt<PersonRepository>();
  late final GeneralChangeNotifier generalChangeNotifier = getIt<GeneralChangeNotifier>();

  @override
  PersonState build() {
    void listener() {
      _loadData();
    }
    generalChangeNotifier.isContactsChanged.addListener(listener);
    ref.onDispose(() => generalChangeNotifier.isContactsChanged.removeListener(listener));
    
    _loadData();
    return PersonState();
  }

  Future<void> _loadData() async {
    final contacts = await personRepository.getContacts();
    final contactsOnChatApp = await personRepository.getContactsOnChatApp();
    final contactsNotOnChatApp = await personRepository.getContactsNotOnChatApp();
    
    state = state.copyWith(
      contacts: contacts,
      contactsOnChatApp: contactsOnChatApp,
      contactsNotOnChatApp: contactsNotOnChatApp,
    );
  }

  void createContact(String name, String username) {
    final personService = ref.read(personServiceProvider);
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
