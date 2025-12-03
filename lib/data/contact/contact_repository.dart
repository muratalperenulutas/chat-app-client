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
        status: drift.Value(contact.status.name),
      ),
    );
  }

  Contact _mapContactDataToContact(ContactData data) {
    return Contact(
      id: data.id,
      name: data.name,
      username: data.username,
      status: Status.fromString(data.status),
    );
  }

  Stream<List<Contact>> watchContacts() {
    final db = database;
    final query = db.select(db.contacts).join(
      [drift.leftOuterJoin(db.persons, db.persons.username.equalsExp(db.contacts.username))]
    );
    return query.watch().map((rows) => rows.map((row) {
      final contactData = row.readTable(db.contacts);
      final personData = row.readTableOrNull(db.persons);
      return Contact(
        id: contactData.id,
        name: contactData.name,
        username: contactData.username,
        status: Status.fromString(contactData.status),
        personId: personData?.personId,
      );
    }).toList());
  }


  Stream<List<Contact>> watchUnsyncedContacts() {
    final db = database;
    return (db.select(db.contacts)..where((tbl) => tbl.status.equals(Status.created.name)))
        .watch()
        .map((rows) => 
          List<ContactData>.from(rows).map(_mapContactDataToContact).toList()
        );
  }
  
  Future<Contact?> findByUsername(String username) async {
    final db = database;
    final row = await (db.select(db.contacts)..where((tbl) => tbl.username.equals(username))).getSingleOrNull();
    return row != null ? _mapContactDataToContact(row) : null;
  }

  Future<Contact?> findContactByPersonId(String personId) async {
    final db = database;
    final query = db.select(db.contacts).join(
      [drift.leftOuterJoin(db.persons, db.persons.username.equalsExp(db.contacts.username))]
    );
    query.where(db.persons.personId.equals(personId));
    final rows = await query.get();
    if (rows.isNotEmpty) {
      final contactData = rows.first.readTable(db.contacts);
      return _mapContactDataToContact(contactData);
    }
    return null;
  }
}
