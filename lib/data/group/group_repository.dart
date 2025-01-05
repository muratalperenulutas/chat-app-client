import 'package:chat_app/constants/db/table_names.dart';
import 'package:chat_app/data/database_service.dart';
import 'package:chat_app/core/general_change_notifier.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'group.dart';

class GroupRepository {
  final DatabaseService databaseService=Get.find<DatabaseService>();

  Future<Database> get database async => databaseService.getDatabase();
  GeneralChangeNotifier generalChangeNotifier=Get.find<GeneralChangeNotifier>();

  Future<int> insertGroup(GroupModel group) async {
    final db = await database;
    int id=await db.insert(DbTableNames.groupsTableName, group.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    generalChangeNotifier.groupsChanged();
    return id;
  }

  Future<int> updateGroup(GroupModel group, int id) async {
    group.setId(id);
    final db = await database;
    int rowId=await db.update(
      DbTableNames.groupsTableName,
      group.toDb(),
      where: 'id = ?',
      whereArgs: [id],
    );
    generalChangeNotifier.groupsChanged();
    return rowId;
  }

  Future<List<GroupModel>> getGroups() async {
    final db = await database;
    final list =
        await db.rawQuery('SELECT * FROM ${DbTableNames.groupsTableName}');
    return list.map((map) => GroupModel.fromDb(map)).toList();
  }

  Future<GroupModel?> getDirectGroupByUserId(String userId) async {
    final db = await database;
    final list = await db.rawQuery('''
    SELECT * FROM ${DbTableNames.groupsTableName} g
    JOIN ${DbTableNames.groupParticipantsTableName} gp ON g.id = gp.localGroupId
    WHERE g.isDirectGroup = 1 AND gp.userId = ?
  ''', [userId]);
    return list.isNotEmpty ? GroupModel.fromDb(list.first) : null;
  }

  Future<GroupModel> getGroupByGroupId(String groupId) async {
    final db = await database;
    final list = await db.rawQuery(
        'SELECT * FROM ${DbTableNames.groupsTableName} WHERE groupId = ?', [groupId]);
    return list.map((map) => GroupModel.fromDb(map)).toList().first;
  }


}