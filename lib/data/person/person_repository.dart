import 'package:chat_app/constants/enums/status.dart';
import 'package:chat_app/data/person/person.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart' as drift;

import '../database_service.dart';
import '../database/database.dart';

@singleton
class PersonRepository {
  final DatabaseService databaseService;

  PersonRepository(this.databaseService);

  AppDatabase get database => databaseService.getDatabase();

  Person _mapPersonDataToPerson(PersonData data) {
    return Person(
      id: data.id,
      personId: data.personId,
      name: data.name,
      username: data.username,
      description: data.description,
      imageId: data.imageId,
      status: Status.fromString(data.status),
    );
  }

  Stream<List<Person>> watchUnsyncedPersons() {
    final db = database;
    return (db.select(db.persons)..where((tbl) => tbl.status.isNotValue(Status.sync.name)))
        .watch()
        .map((rows) => List<PersonData>.from(rows).map(_mapPersonDataToPerson).toList());
  }

  Future<void> insertPerson(Person person) async {
    final db = database;
    try {
      await db.into(db.persons).insert(
        PersonsCompanion.insert(
          personId: person.personId ?? '',
          name: drift.Value(person.name),
          username: drift.Value(person.username),
          description: drift.Value(person.description),
          imageId: drift.Value(person.imageId),
          status: drift.Value(person.status.name),
        ),
      );
    } catch (e) {
      debugPrint("Error inserting person: $e");
      rethrow;
    }
  }

  Future<Person?> findPersonByUsername(String username) async {
    final db = database;
    final row = await (db.select(db.persons)..where((tbl) => tbl.username.equals(username))).getSingleOrNull();
    return row != null ? _mapPersonDataToPerson(row) : null;
  }

  Future<Person?> findPersonByUsernameOrUserId(String username, String userId) async {
    final db = database;
    final row = await (db.select(db.persons)
      ..where((tbl) => tbl.username.equals(username) | tbl.personId.equals(userId)))
      .getSingleOrNull();
    return row != null ? _mapPersonDataToPerson(row) : null;
  }

  Future<Person?> findPersonByPersonId(String personId) async {
    final db = database;
    final row = await (db.select(db.persons)..where((tbl) => tbl.personId.equals(personId))).getSingleOrNull();
    return row != null ? _mapPersonDataToPerson(row) : null;
  }

  Future<void> createPersonIfNotExist(String personId)async{
    Person? person=await findPersonByPersonId(personId);
    if(person==null){
      Person personModel=Person(status: Status.created,personId: personId);
      insertPerson(personModel);
    }
  }

  Future<List<Person>> getUnscncedPerson() async {
    final db = database;
    final rows = await (db.select(db.persons)..where((tbl) => tbl.status.isNotValue(Status.sync.name))).get();
    return rows.map(_mapPersonDataToPerson).toList();
  }

  Future<void> updatePerson(Person person) async {
    final db = database;
    await (db.update(db.persons)..where((tbl) => tbl.id.equals(person.id!))).write(
      PersonsCompanion(
        personId: drift.Value(person.personId ?? ''),
        name: drift.Value(person.name),
        username: drift.Value(person.username),
        description: drift.Value(person.description),
        imageId: drift.Value(person.imageId),
        status: drift.Value(person.status.name),
      ),
    );
  }

  Future<void> printAll() async {
    /*
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.persons}',
      readsFrom: {db.persons},
    );
    
    final results = await query.get();
    debugPrint(results.map((r) => r.data).toList().toString());
    */
  }

}