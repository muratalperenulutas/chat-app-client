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
    await db.into(db.contacts).insert(
      ContactsCompanion.insert(
        name: contact.name,
        username: contact.username,
        personId: drift.Value(contact.personId),
        status: drift.Value(contact.status.name),
      ),
      mode: drift.InsertMode.insertOrReplace,
    );
  }

  Future<void> updateContact(Contact contact) async {
    final db = database;
    await (db.update(db.contacts)..where((tbl) => tbl.id.equals(contact.id!))).write(
      ContactsCompanion(
        name: drift.Value(contact.name),
        username: drift.Value(contact.username),
        personId: drift.Value(contact.personId),
        status: drift.Value(contact.status.name),
      ),
    );
  }

  Contact _mapContactDataToContact(ContactData data) {
    return Contact(
      id: data.id,
      name: data.name,
      username: data.username,
      personId: data.personId,
      status: Status.fromString(data.status),
    );
  }

  Stream<List<Contact>> watchContacts() {
    final db = database;
    return db.select(db.contacts).watch().map((rows) => 
      List<ContactData>.from(rows).map(_mapContactDataToContact).toList()
    );
  }

  Stream<List<Contact>> watchUnsyncedContacts() {
    final db = database;
    return (db.select(db.contacts)..where((tbl) => tbl.status.equals(Status.created.name)))
        .watch()
        .map((rows) => 
          List<ContactData>.from(rows).map(_mapContactDataToContact).toList()
        );
  }

  Future<List<Contact>> getUnsyncedContacts() async {
    final db = database;
    final rows = await (db.select(db.contacts)..where((tbl) => tbl.status.equals(Status.created.name))).get();
    return rows.map(_mapContactDataToContact).toList();
  }

  Future<List<Contact>> getContacts() async {
    final db = database;
    final rows = await db.select(db.contacts).get();
    return rows.map(_mapContactDataToContact).toList();
  }

  Future<List<Contact>> getContactsOnChatApp() async {
    final db = database;
    final rows = await (db.select(db.contacts)..where((tbl) => tbl.personId.isNotNull())).get();
    return rows.map(_mapContactDataToContact).toList();
  }

  Future<List<Contact>> getContactsNotOnChatApp() async {
    final db = database;
    final rows = await (db.select(db.contacts)..where((tbl) => tbl.personId.isNull())).get();
    return rows.map(_mapContactDataToContact).toList();
  }
  
  Future<Contact?> findContactByUsername(String username) async {
    final db = database;
    final row = await (db.select(db.contacts)..where((tbl) => tbl.username.equals(username))).getSingleOrNull();
    return row != null ? _mapContactDataToContact(row) : null;
  }

  Future<Contact?> findContactByPersonId(String personId) async {
    final db = database;
    final row = await (db.select(db.contacts)..where((tbl) => tbl.personId.equals(personId))).getSingleOrNull();
    return row != null ? _mapContactDataToContact(row) : null;
  }
}
