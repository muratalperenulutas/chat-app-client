import 'package:chat_app/constants/db/table_names.dart';
import 'package:chat_app/constants/enums/status.dart';
import 'package:chat_app/data/person/person.dart';
import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:chat_app/core/general_change_notifier.dart';
import 'package:get/get.dart';
import 'package:drift/drift.dart' as drift;

import '../../constants/enums/source_enum.dart';
import '../database_service.dart';
import '../database/database.dart';

class PersonRepository {
  final DatabaseService databaseService=Get.find<DatabaseService>();
  final AuthController authController=Get.find<AuthController>();
  AppDatabase get database => databaseService.getDatabase();
  GeneralChangeNotifier generalChangeNotifier=Get.find<GeneralChangeNotifier>();

  Future<void> insertPerson(Person person) async {
    final db = database;
    final map = person.toDb();
    try {
      await db.customInsert(
        'INSERT INTO ${DbTableNames.persons} '
        '(id, personId, name, localName, username, description, imageId, source, isRegistered, status) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        variables: [
          drift.Variable.withInt(map['id']),
          drift.Variable.withString(map['personId']),
          drift.Variable.withString(map['name']),
          drift.Variable.withString(map['localName']),
          drift.Variable.withString(map['username']),
          drift.Variable.withString(map['description']),
          drift.Variable.withString(map['imageId']),
          drift.Variable.withString(map['source']),
          drift.Variable.withInt(map['isRegistered']),
          drift.Variable.withString(map['status']),
        ],
        updates: {db.persons},
      );
    } catch (e) {
      print("Error inserting person: $e");
      rethrow;
    }
    generalChangeNotifier.contactsChanged();
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
      return Person.fromDb(results.first.data);
    } else {
      return null;
    }
  }

  Future<Person?> findPersonByUsernameOrUserId(String username, String userId) async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.persons} WHERE username = ? OR personId = ?',
      variables: [
        drift.Variable.withString(username),
        drift.Variable.withString(userId),
      ],
      readsFrom: {db.persons},
    );
    
    final results = await query.get();
    if (results.isNotEmpty) {
      return Person.fromDb(results.first.data);
    } else {
      return null;
    }
  }

  Future<Person?> findPersonByPersonId(String personId) async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.persons} WHERE personId = ?',
      variables: [drift.Variable.withString(personId)],
      readsFrom: {db.persons},
    );
    
    final results = await query.get();
    if(results.isEmpty){
      return null;
    }
    return Person.fromDb(results.first.data);
  }

  Future<void> createPersonIfNotExist(String personId)async{
    Person? person=await findPersonByPersonId(personId);
    if(person==null){
      Person personModel=Person(status: Status.CREATED,personId: personId);
      insertPerson(personModel);
    }
  }

  Future<List<Person>> getContacts() async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.persons} WHERE source = ?',
      variables: [drift.Variable.withString(SourceEnum.LOCAL.name)],
      readsFrom: {db.persons},
    );
    
    final results = await query.get();
    return results.map((row) => Person.fromDb(row.data)).toList();
  }

  Future<List<Person>> getContactsOnChatApp() async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.persons} WHERE source = ? AND isRegistered = ?',
      variables: [
        drift.Variable.withString(SourceEnum.LOCAL.name),
        drift.Variable.withInt(1),
      ],
      readsFrom: {db.persons},
    );
    
    final results = await query.get();
    return results.map((row) => Person.fromDb(row.data)).toList();
  }

  Future<List<Person>> getContactsNotOnChatApp() async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.persons} WHERE source = ? AND isRegistered = ?',
      variables: [
        drift.Variable.withString(SourceEnum.LOCAL.name),
        drift.Variable.withInt(0),
      ],
      readsFrom: {db.persons},
    );
    
    final results = await query.get();
    return results.map((row) => Person.fromDb(row.data)).toList();
  }

  Future<List<Person>> getUnscncedPerson() async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.persons} WHERE status != ?',
      variables: [drift.Variable.withString(Status.SYNC.name)],
      readsFrom: {db.persons},
    );
    
    final results = await query.get();
    return results.map((row) => Person.fromDb(row.data)).toList();
  }

  Future<void> updatePerson(Person person) async {
    final db = database;
    final map = person.toDb();
    await db.customUpdate(
      'UPDATE ${DbTableNames.persons} SET '
      'personId = ?, name = ?, localName = ?, username = ?, description = ?, '
      'imageId = ?, source = ?, isRegistered = ?, status = ? WHERE id = ?',
      variables: [
        drift.Variable.withString(map['personId']),
        drift.Variable.withString(map['name']),
        drift.Variable.withString(map['localName']),
        drift.Variable.withString(map['username']),
        drift.Variable.withString(map['description']),
        drift.Variable.withString(map['imageId']),
        drift.Variable.withString(map['source']),
        drift.Variable.withInt(map['isRegistered']),
        drift.Variable.withString(map['status']),
        drift.Variable.withInt(map['id']),
      ],
      updates: {db.persons},
    );
    generalChangeNotifier.contactsChanged();
  }

  Future<void> printAll() async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.persons}',
      readsFrom: {db.persons},
    );
    
    final results = await query.get();
    print(results.map((r) => r.data).toList());
  }
}
