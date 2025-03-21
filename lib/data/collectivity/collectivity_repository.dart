import 'package:chat_app/constants/db/table_names.dart';
import 'package:chat_app/constants/enums/collectivity_type.dart';
import 'package:chat_app/data/collectivity/collectivity_abstract.dart';
import 'package:chat_app/data/collectivity/dyad.dart';
import 'package:chat_app/data/database_service.dart';
import 'package:chat_app/core/general_change_notifier.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'group.dart';

class CollectivityRepository {
  final DatabaseService databaseService=Get.find<DatabaseService>();

  Future<Database> get database async => databaseService.getDatabase();
  GeneralChangeNotifier generalChangeNotifier=Get.find<GeneralChangeNotifier>();

  Future<void> insertGroup(GroupModel group) async {
    final db = await database;
    await db.insert(DbTableNames.collectivity, group.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    generalChangeNotifier.collectivitiesChanged();
  }

  Future<void> updateGroup(GroupModel group, int collectivityId) async {
    final db = await database;
    await db.update(
      DbTableNames.collectivity,
      group.toDb(),
      where: 'collectivityId = ?',
      whereArgs: [collectivityId],
    );
    generalChangeNotifier.collectivitiesChanged();
  }
  Future<void> insertDyad(DyadModel dyad) async {
    final db = await database;
    await db.insert(DbTableNames.collectivity, dyad.toDb(),
        conflictAlgorithm: ConflictAlgorithm.abort);
    generalChangeNotifier.collectivitiesChanged();
  }

  Future<void> updateDyad(DyadModel dyad,int id) async {
    final db = await database;
      await db.update(
        DbTableNames.collectivity,
        dyad.toDb(),
        where: 'id = ?',
        whereArgs: [id],
      );
      generalChangeNotifier.collectivitiesChanged();
  }

  Future<List<Collectivity>> getCollectivities() async {
    final db = await database;
    final list =
        await db.rawQuery('SELECT * FROM ${DbTableNames.collectivity}');
    return list.map((map) => map["collectivityType"]==CollectivityType.GROUP?
    GroupModel.fromDb(map):DyadModel.fromDb(map)).toList();
  }

  Future<GroupModel> getGroupByCollectivityId(int collectivityId) async {
    final db = await database;
    final list = await db.rawQuery(
        'SELECT * FROM ${DbTableNames.collectivity} WHERE collectivityId = ?', [collectivityId]);
    return list.map((map) => GroupModel.fromDb(map)).toList().first;
  }
  Future<DyadModel?> getDyadByUserId(String userId) async {
    final db = await database;
    final list = await db.rawQuery(
      'SELECT * FROM ${DbTableNames.collectivity} WHERE userId = ?', [userId],
    );

    if (list.isNotEmpty) {
      return DyadModel.fromDb(list.first);
    } else {
      return null;
    }
  }
  Future<List<Collectivity>> getUnsyncedCollectivities() async {
    final db = await database;
    final list =
    await db.rawQuery('SELECT * FROM ${DbTableNames.collectivity} WHERE status = \'CREATED\'');
    return list.map((map) => map["collectivityType"]==CollectivityType.GROUP?
    GroupModel.fromDb(map):DyadModel.fromDb(map)).toList();
  }
  Future<void> printAll() async {
    final db = await database;
    final list =
        await db.rawQuery('SELECT * FROM ${DbTableNames.collectivity}');
    print(list);
  }

}