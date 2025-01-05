import 'package:chat_app/constants/db/table_names.dart';
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
        DbTableNames.personsTableName,
        person.toDb(),
        conflictAlgorithm: ConflictAlgorithm.fail,
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
      DbTableNames.personsTableName,
      where: 'username = ?',
      whereArgs: [username],
    );

    if (result.isNotEmpty) {
      return PersonModel.fromDb(result.first);
    } else {
      return null;
    }
  }
  Future<List<PersonModel>> getContacts() async {
    final db = await database;
    final list = await db.rawQuery(
        'SELECT * FROM ${DbTableNames.personsTableName} WHERE source = ?',
        [SourceEnum.LOCAL.toString()]);
    return list.map((map) => PersonModel.fromDb(map)).toList();
  }

  Future<List<PersonModel>> getContactsOnChatApp() async {
    final db = await database;
    final list = await db.rawQuery(
        'SELECT * FROM ${DbTableNames.personsTableName} WHERE source = ? AND isRegistered = ?',
        [SourceEnum.LOCAL.toString(), 1]);
    return list.map((map) => PersonModel.fromDb(map)).toList();
  }

  Future<List<PersonModel>> getContactsNotOnChatApp() async {
    final db = await database;
    final list = await db.rawQuery(
        'SELECT * FROM ${DbTableNames.personsTableName} WHERE source = ? AND isRegistered = ?',
        [SourceEnum.LOCAL.toString(), 0]);
    return list.map((map) => PersonModel.fromDb(map)).toList();
  }
  Future<int> updatePerson(PersonModel person,int personId) async {
    final db = await database;
    return db.update(
      DbTableNames.personsTableName,
      person.toDb(),
      where: 'id = ?',
      whereArgs: [personId],
    );
  }

  Future<PersonModel?> getPersonFromDirectGroupByLocalId(int id) async {
    final db = await database;
    final list = await db.rawQuery('''
    SELECT p.* FROM ${DbTableNames.personsTableName} p
    JOIN ${DbTableNames.groupParticipantsTableName} gp ON p.personId = gp.userId
    JOIN ${DbTableNames.groupsTableName} g ON gp.localGroupId = g.id
    WHERE g.isDirectGroup = 1 AND g.id = ?
  ''', [id]);

    if (list.isNotEmpty && list.length == 2) {
      final otherParticipant =
      list.firstWhere((map) => map['personId'] != authController.userId.value.toString());
      PersonModel personModel= PersonModel.fromDb(otherParticipant);
      return personModel;
    }
    return null;
  }
}
