import 'package:chat_app/constants/db/table_names.dart';
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

  Person _mapRowToPerson(drift.QueryRow row) {
    return Person(
      id: row.read<int>('id'),
      personId: row.read<String?>('person_id'),
      name: row.read<String?>('name'),
      username: row.read<String?>('username'),
      description: row.read<String?>('description'),
      imageId: row.read<String?>('image_id'),
      status: Status.fromString(row.read<String>('status')),
    );
  }

  Stream<List<Person>> watchUnsyncedPersons() {
    final db = database;
    
    return db.customSelect(
      'SELECT * FROM ${DbTableNames.persons} WHERE status != ?',
      variables: [drift.Variable.withString(Status.sync.name)],
      readsFrom: {db.persons},
    ).watch().map((rows) => 
      rows.map(_mapRowToPerson).toList()
    );
  }

  Future<void> insertPerson(Person person) async {
    final db = database;
    try {
      await db.customInsert(
        'INSERT INTO ${DbTableNames.persons} '
        '(person_id, name, username, description, image_id, status) '
        'VALUES (?, ?, ?, ?, ?, ?)',
        variables: [
          drift.Variable.withString(person.personId ?? ''),
          drift.Variable.withString(person.name ?? ''),
          drift.Variable.withString(person.username ?? ''),
          drift.Variable.withString(person.description ?? ''),
          drift.Variable.withString(person.imageId ?? ''),
          drift.Variable.withString(person.status.name),
        ],
        updates: {db.persons},
      );
    } catch (e) {
      debugPrint("Error inserting person: $e");
      rethrow;
    }
  }

  Future<Person?> findPersonByUsername(String username) async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.persons} WHERE username = ?',
      variables: [drift.Variable.withString(username)],
      readsFrom: {db.persons},
    );
    
    final results = await query.get();
    if (results.isNotEmpty) {
      return _mapRowToPerson(results.first);
    } else {
      return null;
    }
  }

  Future<Person?> findPersonByUsernameOrUserId(String username, String userId) async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.persons} WHERE username = ? OR person_id = ?',
      variables: [
        drift.Variable.withString(username),
        drift.Variable.withString(userId),
      ],
      readsFrom: {db.persons},
    );
    
    final results = await query.get();
    if (results.isNotEmpty) {
      return _mapRowToPerson(results.first);
    } else {
      return null;
    }
  }

  Future<Person?> findPersonByPersonId(String personId) async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.persons} WHERE person_id = ?',
      variables: [drift.Variable.withString(personId)],
      readsFrom: {db.persons},
    );
    
    final results = await query.get();
    if(results.isEmpty){
      return null;
    }
    return _mapRowToPerson(results.first);
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
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.persons} WHERE status != ?',
      variables: [drift.Variable.withString(Status.sync.name)],
      readsFrom: {db.persons},
    );
    
    final results = await query.get();
    return results.map(_mapRowToPerson).toList();
  }

  Future<void> updatePerson(Person person) async {
    final db = database;
    await db.customUpdate(
      'UPDATE ${DbTableNames.persons} SET '
      'person_id = ?, name = ?, username = ?, description = ?, '
      'image_id = ?, status = ? WHERE id = ?',
      variables: [
        drift.Variable.withString(person.personId ?? ''),
        drift.Variable.withString(person.name ?? ''),
        drift.Variable.withString(person.username ?? ''),
        drift.Variable.withString(person.description ?? ''),
        drift.Variable.withString(person.imageId ?? ''),
        drift.Variable.withString(person.status.name),
        drift.Variable.withInt(person.id!),
      ],
      updates: {db.persons},
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