import 'package:chat_app/constants/enums/status.dart';
import 'package:chat_app/constants/db/table_names.dart';
import 'package:chat_app/constants/enums/collectivity_type.dart';
import 'package:chat_app/data/collectivity/collectivity_abstract.dart';
import 'package:chat_app/data/collectivity/dyad.dart';
import 'package:chat_app/data/database_service.dart';
import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart' as drift;
import '../database/database.dart';
import 'group.dart';

@singleton
class CollectivityRepository {
  final DatabaseService databaseService;

  CollectivityRepository(this.databaseService);

  AppDatabase get database => databaseService.getDatabase();

  Group _mapRowToGroup(drift.QueryRow row) {
    return Group(
      id: row.read<int>('id'),
      collectivityId: row.read<String?>('collectivityId'),
      name: row.read<String?>('name'),
      type: CollectivityType.fromString(row.read<String>('collectivity_type')),
      creatorId: row.read<String?>('creator_id'),
      imageId: row.read<String?>('image_id'),
      status: Status.fromString(row.read<String>('status')),
    );
  }

  Dyad _mapRowToDyad(drift.QueryRow row) {
    return Dyad(
      id: row.read<int>('id'),
      userId: row.read<String?>('user_id') ?? "",
      collectivityId: row.read<String?>('collectivityId'),
      status: Status.fromString(row.read<String>('status')),
      type: CollectivityType.fromString(row.read<String>('collectivity_type')),
    );
  }

  Collectivity _mapRowToCollectivity(drift.QueryRow row) {
    final type = row.read<String>('collectivity_type');
    if (type == CollectivityType.group.name) {
      return _mapRowToGroup(row);
    } else {
      return _mapRowToDyad(row);
    }
  }

  Stream<List<Collectivity>> watchUnsyncedCollectivities() {
    final db = database;
    
    return db.customSelect(
      'SELECT * FROM ${DbTableNames.collectivity} WHERE status = \'CREATED\'',
      readsFrom: {db.collectivities},
    ).watch().map((rows) => 
      rows.map(_mapRowToCollectivity).toList()
    );
  }

  Future<void> insertGroup(Group group) async {
    final db = database;
    await db.customInsert(
      'INSERT OR REPLACE INTO ${DbTableNames.collectivity} '
      '(collectivityId, name, creator_id, image_id, collectivity_type, status) '
      'VALUES (?, ?, ?, ?, ?, ?)',
      variables: [
        drift.Variable.withString(group.collectivityId ?? ''),
        drift.Variable.withString(group.name ?? ''),
        drift.Variable.withString(group.creatorId ?? ''),
        drift.Variable.withString(group.imageId ?? ''),
        drift.Variable.withString(group.type.name),
        drift.Variable.withString(group.status.name),
      ],
      updates: {db.collectivities},
    );
  }

  Future<void> insertGroupList(List<Group> groups) async {
    final db = database;
    for (var group in groups) {
      await db.customInsert(
        'INSERT OR REPLACE INTO ${DbTableNames.collectivity} '
        '(collectivityId, name, creator_id, image_id, collectivity_type, status) '
        'VALUES (?, ?, ?, ?, ?, ?)',
        variables: [
          drift.Variable.withString(group.collectivityId ?? ''),
          drift.Variable.withString(group.name ?? ''),
          drift.Variable.withString(group.creatorId ?? ''),
          drift.Variable.withString(group.imageId ?? ''),
          drift.Variable.withString(group.type.name),
          drift.Variable.withString(group.status.name),
        ],
        updates: {db.collectivities},
      );
    }
  }

  Future<void> updateGroup(Group group, int collectivityId) async {
    final db = database;
    await db.customUpdate(
      'UPDATE ${DbTableNames.collectivity} SET '
      'name = ?, creator_id = ?, image_id = ?, collectivity_type = ?, status = ? '
      'WHERE collectivityId = ?',
      variables: [
        drift.Variable.withString(group.name ?? ''),
        drift.Variable.withString(group.creatorId ?? ''),
        drift.Variable.withString(group.imageId ?? ''),
        drift.Variable.withString(group.type.name),
        drift.Variable.withString(group.status.name),
        drift.Variable.withInt(collectivityId),
      ],
      updates: {db.collectivities},
    );
  }

  Future<void> insertDyad(Dyad dyad) async {
    final db = database;
    await db.customInsert(
      'INSERT OR REPLACE INTO ${DbTableNames.collectivity} '
      '(collectivityId, user_id, collectivity_type, status) '
      'VALUES (?, ?, ?, ?)',
      variables: [
        drift.Variable.withString(dyad.collectivityId ?? ''),
        drift.Variable.withString(dyad.userId),
        drift.Variable.withString(dyad.type.name),
        drift.Variable.withString(dyad.status.name),
      ],
      updates: {db.collectivities},
    );
  }

  Future<void> insertDyadList(List<Dyad> dyads) async {
    final db = database;
    for (var dyad in dyads) {
      await db.customInsert(
        'INSERT OR REPLACE INTO ${DbTableNames.collectivity} '
        '(collectivityId, user_id, collectivity_type, status) '
        'VALUES (?, ?, ?, ?)',
        variables: [
          drift.Variable.withString(dyad.collectivityId ?? ''),
          drift.Variable.withString(dyad.userId),
          drift.Variable.withString(dyad.type.name),
          drift.Variable.withString(dyad.status.name),
        ],
        updates: {db.collectivities},
      );
    }
  }

  Future<void> updateDyad(Dyad dyad) async {
    final db = database;
    await db.customUpdate(
      'UPDATE ${DbTableNames.collectivity} SET '
      'collectivityId = ?, collectivity_type = ?, status = ? WHERE user_id = ?',
      variables: [
        drift.Variable.withString(dyad.collectivityId ?? ''),
        drift.Variable.withString(dyad.type.name),
        drift.Variable.withString(dyad.status.name),
        drift.Variable.withString(dyad.userId),
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
    return results.map(_mapRowToCollectivity).toList();
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
    return results.map(_mapRowToGroup).toList().first;
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
      return _mapRowToDyad(results.first);
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
    return results.map(_mapRowToCollectivity).toList();
  }

  Future<void> printAll() async {
    /*
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.collectivity}',
      readsFrom: {db.collectivities},
    );
    
    final results = await query.get();
    debugPrint(results.map((r) => r.data).toList().toString());
    */
  }
}
