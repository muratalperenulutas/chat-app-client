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

  Group _mapCollectivityDataToGroup(CollectivityData data) {
    return Group(
      id: data.id,
      collectivityId: data.collectivityId,
      name: data.name,
      type: CollectivityType.fromString(data.collectivityType ?? ''),
      creatorId: data.creatorId,
      imageId: data.imageId,
      status: Status.fromString(data.status),
    );
  }

  Dyad _mapCollectivityDataToDyad(CollectivityData data) {
    return Dyad(
      id: data.id,
      userId: data.userId ?? "",
      collectivityId: data.collectivityId,
      status: Status.fromString(data.status),
      type: CollectivityType.fromString(data.collectivityType ?? ''),
    );
  }

  Collectivity _mapCollectivityDataToCollectivity(CollectivityData data) {
    final type = data.collectivityType;
    if (type == CollectivityType.group.name) {
      return _mapCollectivityDataToGroup(data);
    } else {
      return _mapCollectivityDataToDyad(data);
    }
  }

  Stream<List<Collectivity>> watchCollectivities() {
    final db = database;
    return db.select(db.collectivities).watch().map((rows) => 
      List<CollectivityData>.from(rows).map(_mapCollectivityDataToCollectivity).toList()
    );
  }

  Stream<List<Collectivity>> watchUnsyncedCollectivities() {
    final db = database;
    return (db.select(db.collectivities)..where((tbl) => tbl.status.equals(Status.created.name)))
        .watch()
        .map((rows) => 
          List<CollectivityData>.from(rows).map(_mapCollectivityDataToCollectivity).toList()
        );
  }

  Future<void> checkPendingCollectivitiesTimeout() async {
    final db = database;
    final timeoutThreshold = DateTime.now().subtract(const Duration(minutes: 1));
    
    await (db.update(db.collectivities)
      ..where((tbl) => tbl.status.equals(Status.pending.name) & tbl.createdAt.isSmallerThanValue(timeoutThreshold)))
      .write(CollectivitiesCompanion(status: drift.Value(Status.failed.name)));
  }

  Future<void> insertGroup(Group group) async {
    final db = database;
    await db.into(db.collectivities).insert(
      CollectivitiesCompanion.insert(
        collectivityId: group.collectivityId ?? '',
        name: drift.Value(group.name),
        creatorId: drift.Value(group.creatorId),
        imageId: drift.Value(group.imageId),
        collectivityType: drift.Value(group.type.name),
        status: drift.Value(group.status.name),
      ),
      mode: drift.InsertMode.insertOrReplace,
    );
  }

  Future<void> insertGroupList(List<Group> groups) async {
    final db = database;
    await db.batch((batch) {
      batch.insertAll(
        db.collectivities,
        groups.map((group) => CollectivitiesCompanion.insert(
          collectivityId: group.collectivityId ?? '',
          name: drift.Value(group.name),
          creatorId: drift.Value(group.creatorId),
          imageId: drift.Value(group.imageId),
          collectivityType: drift.Value(group.type.name),
          status: drift.Value(group.status.name),
        )),
        mode: drift.InsertMode.insertOrReplace,
      );
    });
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
    await db.into(db.collectivities).insert(
      CollectivitiesCompanion.insert(
        collectivityId: dyad.collectivityId ?? '',
        userId: drift.Value(dyad.userId),
        collectivityType: drift.Value(dyad.type.name),
        status: drift.Value(dyad.status.name),
      ),
      mode: drift.InsertMode.insertOrReplace,
    );
  }

  Future<void> insertDyadList(List<Dyad> dyads) async {
    final db = database;
    await db.batch((batch) {
      batch.insertAll(
        db.collectivities,
        dyads.map((dyad) => CollectivitiesCompanion.insert(
          collectivityId: dyad.collectivityId ?? '',
          userId: drift.Value(dyad.userId),
          collectivityType: drift.Value(dyad.type.name),
          status: drift.Value(dyad.status.name),
        )),
        mode: drift.InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> updateDyad(Dyad dyad) async {
    final db = database;
    await (db.update(db.collectivities)..where((tbl) => tbl.userId.equals(dyad.userId))).write(
      CollectivitiesCompanion(
        collectivityId: drift.Value(dyad.collectivityId ?? ''),
        collectivityType: drift.Value(dyad.type.name),
        status: drift.Value(dyad.status.name),
      ),
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
    final rows = await db.select(db.collectivities).get();
    return rows.map(_mapCollectivityDataToCollectivity).toList();
  }

  Future<int> isExistByCollectivityIdId(String collectivityId) async {
    final db = database;
    final count = await (db.select(db.collectivities)..where((tbl) => tbl.collectivityId.equals(collectivityId))).get();
    return count.length;
  }

  Future<Group> getGroupByCollectivityId(String collectivityId) async {
    final db = database;
    final row = await (db.select(db.collectivities)..where((tbl) => tbl.collectivityId.equals(collectivityId))).getSingle();
    return _mapCollectivityDataToGroup(row);
  }

  Future<Dyad?> getDyadByUserId(String userId) async {
    final db = database;
    final row = await (db.select(db.collectivities)..where((tbl) => tbl.userId.equals(userId))).getSingleOrNull();
    return row != null ? _mapCollectivityDataToDyad(row) : null;
  }

  Future<List<Collectivity>> getUnsyncedCollectivities() async {
    final db = database;
    final rows = await (db.select(db.collectivities)..where((tbl) => tbl.status.equals(Status.created.name))).get();
    return rows.map(_mapCollectivityDataToCollectivity).toList();
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
