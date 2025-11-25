import 'package:chat_app/constants/db/table_names.dart';
import 'package:chat_app/constants/enums/collectivity_type.dart';
import 'package:chat_app/data/collectivity/collectivity_abstract.dart';
import 'package:chat_app/data/collectivity/dyad.dart';
import 'package:chat_app/data/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart' as drift;
import '../database/database.dart';
import 'group.dart';

@singleton
class CollectivityRepository {
  final DatabaseService databaseService;

  CollectivityRepository(this.databaseService);

  AppDatabase get database => databaseService.getDatabase();

  Stream<List<Collectivity>> watchUnsyncedCollectivities() {
    final db = database;
    
    return db.customSelect(
      'SELECT * FROM ${DbTableNames.collectivity} WHERE status = \'CREATED\'',
      readsFrom: {db.collectivities},
    ).watch().map((rows) => 
      rows.map((row) {
        final map = row.data;
        return map["collectivity_type"] == CollectivityType.group.name
            ? Group.fromDb(map)
            : Dyad.fromDb(map);
      }).toList()
    );
  }

  Future<void> insertGroup(Group group) async {
    final db = database;
    final map = group.toDb();
    await db.customInsert(
      'INSERT OR REPLACE INTO ${DbTableNames.collectivity} '
      '(collectivityId, name, creator_id, image_id, collectivity_type, status) '
      'VALUES (?, ?, ?, ?, ?, ?)',
      variables: [
        drift.Variable.withString(map['collectivityId'] ?? ''),
        drift.Variable.withString(map['name'] ?? ''),
        drift.Variable.withString(map['creator_id'] ?? ''),
        drift.Variable.withString(map['image_id'] ?? ''),
        drift.Variable.withString(map['collectivity_type'] ?? ''),
        drift.Variable.withString(map['status'] ?? ''),
      ],
      updates: {db.collectivities},
    );
  }

  Future<void> insertGroupList(List<Group> groups) async {
    final db = database;
    for (var group in groups) {
      final map = group.toDb();
      await db.customInsert(
        'INSERT OR REPLACE INTO ${DbTableNames.collectivity} '
        '(collectivityId, name, creator_id, image_id, collectivity_type, status) '
        'VALUES (?, ?, ?, ?, ?, ?)',
        variables: [
          drift.Variable.withString(map['collectivityId'] ?? ''),
          drift.Variable.withString(map['name'] ?? ''),
          drift.Variable.withString(map['creator_id'] ?? ''),
          drift.Variable.withString(map['image_id'] ?? ''),
          drift.Variable.withString(map['collectivity_type'] ?? ''),
          drift.Variable.withString(map['status'] ?? ''),
        ],
        updates: {db.collectivities},
      );
    }
  }

  Future<void> updateGroup(Group group, int collectivityId) async {
    final db = database;
    final map = group.toDb();
    await db.customUpdate(
      'UPDATE ${DbTableNames.collectivity} SET '
      'name = ?, creator_id = ?, image_id = ?, collectivity_type = ?, status = ? '
      'WHERE collectivityId = ?',
      variables: [
        drift.Variable.withString(map['name'] ?? ''),
        drift.Variable.withString(map['creator_id'] ?? ''),
        drift.Variable.withString(map['image_id'] ?? ''),
        drift.Variable.withString(map['collectivity_type'] ?? ''),
        drift.Variable.withString(map['status'] ?? ''),
        drift.Variable.withInt(collectivityId),
      ],
      updates: {db.collectivities},
    );
  }

  Future<void> insertDyad(Dyad dyad) async {
    final db = database;
    final map = dyad.toDb();
    await db.customInsert(
      'INSERT OR REPLACE INTO ${DbTableNames.collectivity} '
      '(collectivityId, user_id, collectivity_type, status) '
      'VALUES (?, ?, ?, ?)',
      variables: [
        drift.Variable.withString(map['collectivityId'] ?? ''),
        drift.Variable.withString(map['user_id'] ?? ''),
        drift.Variable.withString(map['collectivity_type'] ?? ''),
        drift.Variable.withString(map['status'] ?? ''),
      ],
      updates: {db.collectivities},
    );
  }

  Future<void> insertDyadList(List<Dyad> dyads) async {
    final db = database;
    for (var dyad in dyads) {
      final map = dyad.toDb();
      await db.customInsert(
        'INSERT OR REPLACE INTO ${DbTableNames.collectivity} '
        '(collectivityId, user_id, collectivity_type, status) '
        'VALUES (?, ?, ?, ?)',
        variables: [
          drift.Variable.withString(map['collectivityId'] ?? ''),
          drift.Variable.withString(map['user_id'] ?? ''),
          drift.Variable.withString(map['collectivity_type'] ?? ''),
          drift.Variable.withString(map['status'] ?? ''),
        ],
        updates: {db.collectivities},
      );
    }
  }

  Future<void> updateDyad(Dyad dyad) async {
    final db = database;
    final map = dyad.toDb();
    await db.customUpdate(
      'UPDATE ${DbTableNames.collectivity} SET '
      'collectivityId = ?, collectivity_type = ?, status = ? WHERE user_id = ?',
      variables: [
        drift.Variable.withString(map['collectivityId'] ?? ''),
        drift.Variable.withString(map['collectivity_type'] ?? ''),
        drift.Variable.withString(map['status'] ?? ''),
        drift.Variable.withString(map['user_id'] ?? ''),
      ],
      updates: {db.collectivities},
    );
  }

  Future<void> createCollectivityIfNotExist(String collectivityId)async{
    int a=await isExistByCollectivityIdId(collectivityId);
    if(a==0){
      Group group=Group(collectivityId: collectivityId);
      await insertGroup(group);
    }
  }

  Future<List<Collectivity>> getCollectivities() async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.collectivity}',
      readsFrom: {db.collectivities},
    );
    
    final results = await query.get();
    return results.map((row) {
      final map = row.data;
      return map["collectivity_type"]==CollectivityType.group.name ?
        Group.fromDb(map) : Dyad.fromDb(map);
    }).toList();
  }

  Future<int> isExistByCollectivityIdId(String collectivityId) async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.collectivity} WHERE collectivityId = ?',
      variables: [drift.Variable.withString(collectivityId)],
      readsFrom: {db.collectivities},
    );
    
    final results = await query.get();
    return results.length;
  }

  Future<Group> getGroupByCollectivityId(int collectivityId) async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.collectivity} WHERE collectivityId = ?',
      variables: [drift.Variable.withInt(collectivityId)],
      readsFrom: {db.collectivities},
    );
    
    final results = await query.get();
    return results.map((row) => Group.fromDb(row.data)).toList().first;
  }

  Future<Dyad?> getDyadByUserId(String userId) async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.collectivity} WHERE user_id = ?',
      variables: [drift.Variable.withString(userId)],
      readsFrom: {db.collectivities},
    );
    
    final results = await query.get();
    if (results.isNotEmpty) {
      return Dyad.fromDb(results.first.data);
    } else {
      return null;
    }
  }

  Future<List<Collectivity>> getUnsyncedCollectivities() async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.collectivity} WHERE status = \'CREATED\'',
      readsFrom: {db.collectivities},
    );
    
    final results = await query.get();
    debugPrint("UnsyncedCollectivity ${results.map((r) => r.data).toList()}");
    return results.map((row) {
      final map = row.data;
      return map["collectivity_type"]==CollectivityType.group.name ?
        Group.fromDb(map) : Dyad.fromDb(map);
    }).toList();
  }

  Future<void> printAll() async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.collectivity}',
      readsFrom: {db.collectivities},
    );
    
    final results = await query.get();
    debugPrint(results.map((r) => r.data).toList().toString());
  }
}
