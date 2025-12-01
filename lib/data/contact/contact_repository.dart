import 'package:chat_app/constants/db/table_names.dart';
import 'package:chat_app/constants/enums/status.dart';
import 'package:chat_app/data/contact/contact.dart';
import 'package:chat_app/data/database_service.dart';
import 'package:chat_app/data/database/database.dart';
import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart' as drift;

@singleton
class ContactRepository {
  final DatabaseService databaseService;

  ContactRepository(this.databaseService);

  AppDatabase get database => databaseService.getDatabase();

  Future<void> insertContact(Contact contact) async {
    final db = database;
    await db.customInsert(
      'INSERT INTO ${DbTableNames.contacts} (name, username, person_id, status) VALUES (?, ?, ?, ?)',
      variables: [
        drift.Variable.withString(contact.name),
        drift.Variable.withString(contact.username),
        drift.Variable<String>(contact.personId),
        drift.Variable.withString(contact.status.name),
      ],
      updates: {db.contacts},
    );
  }

  Future<void> updateContact(Contact contact) async {
    final db = database;
    await db.customUpdate(
      'UPDATE ${DbTableNames.contacts} SET name = ?, username = ?, person_id = ?, status = ? WHERE id = ?',
      variables: [
        drift.Variable.withString(contact.name),
        drift.Variable.withString(contact.username),
        drift.Variable<String>(contact.personId),
        drift.Variable.withString(contact.status.name),
        drift.Variable.withInt(contact.id!),
      ],
      updates: {db.contacts},
    );
  }

  Contact _mapRowToContact(drift.QueryRow row) {
    return Contact(
      id: row.read<int>('id'),
      name: row.read<String>('name'),
      username: row.read<String>('username'),
      personId: row.read<String?>('person_id'),
      status: Status.fromString(row.read<String>('status')),
    );
  }

  Stream<List<Contact>> watchUnsyncedContacts() {
    final db = database;
    return db.customSelect(
      'SELECT * FROM ${DbTableNames.contacts} WHERE status != ?',
      variables: [drift.Variable.withString(Status.sync.name)],
      readsFrom: {db.contacts},
    ).watch().map((rows) {
      // debugPrint("Mapping contacts from DB: ${rows.length}");
      return rows.map(_mapRowToContact).toList();
    });
  }

  Future<List<Contact>> getUnsyncedContacts() async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.contacts} WHERE status != ?',
      variables: [drift.Variable.withString(Status.sync.name)],
      readsFrom: {db.contacts},
    );
    final results = await query.get();
    return results.map(_mapRowToContact).toList();
  }

  Future<List<Contact>> getContacts() async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.contacts}',
      readsFrom: {db.contacts},
    );
    final results = await query.get();
    return results.map(_mapRowToContact).toList();
  }

  Future<List<Contact>> getContactsOnChatApp() async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.contacts} WHERE person_id IS NOT NULL',
      readsFrom: {db.contacts},
    );
    final results = await query.get();
    return results.map(_mapRowToContact).toList();
  }

  Future<List<Contact>> getContactsNotOnChatApp() async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.contacts} WHERE person_id IS NULL',
      readsFrom: {db.contacts},
    );
    final results = await query.get();
    return results.map(_mapRowToContact).toList();
  }
  
  Future<Contact?> findContactByUsername(String username) async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.contacts} WHERE username = ?',
      variables: [drift.Variable.withString(username)],
      readsFrom: {db.contacts},
    );
    final results = await query.get();
    if (results.isNotEmpty) {
      return _mapRowToContact(results.first);
    }
    return null;
  }

  Future<Contact?> findContactByPersonId(String personId) async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.contacts} WHERE person_id = ?',
      variables: [drift.Variable.withString(personId)],
      readsFrom: {db.contacts},
    );
    final results = await query.get();
    if (results.isNotEmpty) {
      return _mapRowToContact(results.first);
    }
    return null;
  }
}
