import 'dart:async';

import 'package:chat_app/constants/enums/status.dart';
import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/services/sync/sync.dart';
import 'package:chat_app/data/contact/contact.dart';
import 'package:chat_app/data/contact/contact_repository.dart';
import 'package:chat_app/data/person/person_service.dart';

import '../../../constants/enums/ws_message_type.dart';
import '../websocket/models/find_user.dart';
import '../websocket/models/websocket_message.dart';

class ContactSyncService {
  final PersonService personService = getIt<PersonService>();
  final ContactRepository contactRepository = getIt<ContactRepository>();
  final SyncService syncService = getIt<SyncService>();
  
  StreamSubscription<List<Contact>>? _unsyncedContactsSubscription;

  ContactSyncService() {
    _setupAutoSync();
  }

  void _setupAutoSync() {
    _unsyncedContactsSubscription = contactRepository.watchUnsyncedContacts().listen((contacts) {
      if (contacts.isNotEmpty) {
        _syncContacts(contacts);
      }
    });
  }

  void _syncContacts(List<Contact> contacts) async {
    for (Contact contact in contacts) {
      FindUser findUser = FindUser(contact.username, contact.personId);
      WebsocketMessage message =
          WebsocketMessage(WsMessageType.FIND_USER, contact.id.toString(), findUser);
      syncService.sendMessage(message);

      Contact updatedContact = Contact(
        id: contact.id,
        name: contact.name,
        username: contact.username,
        personId: contact.personId,
        status: Status.pending,
      );
      await contactRepository.updateContact(updatedContact);
    }
  }

  void findRegisteredPersons() async {
    List<Contact> contacts = await contactRepository.getUnsyncedContacts();
    _syncContacts(contacts);
  }
  
  void dispose() {
    _unsyncedContactsSubscription?.cancel();
  }
}