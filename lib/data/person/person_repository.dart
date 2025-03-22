import 'package:chat_app/constants/db/table_names.dart';
import 'package:chat_app/constants/enums/status.dart';
import 'package:chat_app/data/person/person.dart';
import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:chat_app/core/general_change_notifier.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../constants/enums/source_enum.dart';
import '../database_service.dart';
class PersonRepository {
  final DatabaseService databaseService=Get.find<DatabaseService>();
  final AuthController authController=Get.find<AuthController>();
  Future<Database> get database async => databaseService.getDatabase();
  GeneralChangeNotifier generalChangeNotifier=Get.find<GeneralChangeNotifier>();

  Future<void> insertPerson(PersonModel person) async {
    final db = await database;
    try {
      await db.insert(
        DbTableNames.persons,
        person.toDb(),
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
    } catch (e) {
      print("Error inserting person: $e");

      rethrow;
    }
    generalChangeNotifier.contactsChanged();
  }

  Future<PersonModel?> findPersonByUsername(String username) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      DbTableNames.persons,
      where: 'username = ?',
      whereArgs: [username],
    );

    if (result.isNotEmpty) {
      return PersonModel.fromDb(result.first);
    } else {
      return null;
    }
  }

  Future<PersonModel?> findPersonByUsernameOrUserId(String username, String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      DbTableNames.persons,
      where: 'username = ? OR personId = ?',
      whereArgs: [username, userId],
    );

    if (result.isNotEmpty) {
      return PersonModel.fromDb(result.first);
    } else {
      return null;
    }
  }


  Future<PersonModel?> findPersonByPersonId(String personId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      DbTableNames.persons,
      where: 'personId = ?',
      whereArgs: [personId],
    );
    if(result.isEmpty){
      return null;
    }
    return PersonModel.fromDb(result.first);
  }

  Future<void> createPersonIfNotExist(String personId)async{
    PersonModel? person=await findPersonByPersonId(personId);
    if(person==null){
      PersonModel personModel=PersonModel(status: Status.CREATED,personId: personId);
      insertPerson(personModel);
    }
  }

  Future<List<PersonModel>> getContacts() async {
    final db = await database;
    final list = await db.rawQuery(
        'SELECT * FROM ${DbTableNames.persons} WHERE source = ?',
        [SourceEnum.LOCAL.toString()]);
    return list.map((map) => PersonModel.fromDb(map)).toList();
  }

  Future<List<PersonModel>> getContactsOnChatApp() async {
    final db = await database;
    final list = await db.rawQuery(
        'SELECT * FROM ${DbTableNames.persons} WHERE source = ? AND isRegistered = ?',
        [SourceEnum.LOCAL.toString(), 1]);
    return list.map((map) => PersonModel.fromDb(map)).toList();
  }

  Future<List<PersonModel>> getContactsNotOnChatApp() async {
    final db = await database;
    final list = await db.rawQuery(
        'SELECT * FROM ${DbTableNames.persons} WHERE source = ? AND isRegistered = ?',
        [SourceEnum.LOCAL.toString(), 0]);
    return list.map((map) => PersonModel.fromDb(map)).toList();
  }
  Future<List<PersonModel>> getUnscncedPerson() async {
    final db = await database;
    final list = await db.rawQuery(
        'SELECT * FROM ${DbTableNames.persons} WHERE status != ?',
        [Status.SYNC.name]);
    return list.map((map) => PersonModel.fromDb(map)).toList();
  }

  Future<void> updatePerson(PersonModel person) async {
    final db = await database;
    await db.update(
      DbTableNames.persons,
      person.toDb(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    generalChangeNotifier.contactsChanged();
  }

  Future<void> printAll() async {
      final db = await database;
      final list = await db.rawQuery(
          'SELECT * FROM ${DbTableNames.persons} ');
     print(list);
  }

}
