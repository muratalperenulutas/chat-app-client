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

  Future<void> insertGroup(Group group) async {
    final db = await database;
    await db.insert(DbTableNames.collectivity, group.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    generalChangeNotifier.collectivitiesChanged();
  }
  Future<void> insertGroupList(List<Group> groups) async {
    final db = await database;

    Batch batch = db.batch();
    for (var group in groups) {
      batch.insert(
        DbTableNames.collectivity,
        group.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
    generalChangeNotifier.collectivitiesChanged();
  }

  Future<void> updateGroup(Group group, int collectivityId) async {
    final db = await database;
    await db.update(
      DbTableNames.collectivity,
      group.toDb(),
      where: 'collectivityId = ?',
      whereArgs: [collectivityId],
    );
    generalChangeNotifier.collectivitiesChanged();
  }
  Future<void> insertDyad(Dyad dyad) async {
    final db = await database;
    await db.insert(DbTableNames.collectivity, dyad.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    generalChangeNotifier.collectivitiesChanged();
  }
  Future<void> insertDyadList(List<Dyad> dyads) async {
    final db = await database;
      Batch batch = db.batch();
      for (var dyad in dyads) {
        batch.insert(
          DbTableNames.collectivity,
          dyad.toDb(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    generalChangeNotifier.collectivitiesChanged();
  }
  Future<void> updateDyad(Dyad dyad) async {
    final db = await database;
    await db.update(
      DbTableNames.collectivity,
      dyad.toDb(),
      where: 'userId = ?',
      whereArgs: [dyad.userId],
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    generalChangeNotifier.collectivitiesChanged();
  }
  Future<void> createCollectivityIfNotExist(String collectivityId)async{
    int a=await isExistByCollectivityIdId(collectivityId);
    if(a==0){
      Group group=Group(collectivityId: collectivityId);
      await insertGroup(group);
    }
  }

  Future<List<Collectivity>> getCollectivities() async {
    final db = await database;
    final list =
        await db.rawQuery('SELECT * FROM ${DbTableNames.collectivity}');
    return list.map((map) => map["collectivityType"]==CollectivityType.GROUP.name?
    Group.fromDb(map):Dyad.fromDb(map)).toList();
  }
  Future<int> isExistByCollectivityIdId(String collectivityId) async {
    final db = await database;
    final list = await db.rawQuery(
        'SELECT * FROM ${DbTableNames.collectivity} WHERE collectivityId = ?', [collectivityId]);
    return list.length;
  }

  Future<Group> getGroupByCollectivityId(int collectivityId) async {
    final db = await database;
    final list = await db.rawQuery(
        'SELECT * FROM ${DbTableNames.collectivity} WHERE collectivityId = ?', [collectivityId]);
    return list.map((map) => Group.fromDb(map)).toList().first;
  }
  Future<Dyad?> getDyadByUserId(String userId) async {
    final db = await database;
    final list = await db.rawQuery(
      'SELECT * FROM ${DbTableNames.collectivity} WHERE userId = ?', [userId],
    );

    if (list.isNotEmpty) {
      return Dyad.fromDb(list.first);
    } else {
      return null;
    }
  }
  Future<List<Collectivity>> getUnsyncedCollectivities() async {
    final db = await database;
    final list =
    await db.rawQuery('SELECT * FROM ${DbTableNames.collectivity} WHERE status = \'CREATED\'');
    print("UnsyncedCollectivity $list");
    return list.map((map) => map["collectivityType"]==CollectivityType.GROUP?
    Group.fromDb(map):Dyad.fromDb(map)).toList();
  }
  Future<void> printAll() async {
    final db = await database;
    final list =
        await db.rawQuery('SELECT * FROM ${DbTableNames.collectivity}');
    print(list);
  }

}