import 'package:chat_app/constants/enums/status.dart';
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

  Group _mapGroupDataToGroup(GroupData data) {
    return Group(
      id: data.id,
      collectivityId: data.collectivityId,
      name: data.name,
      creatorId: data.creatorId,
      imageId: data.imageId,
      status: Status.fromString(data.status),
    );
  }

  Dyad _mapDyadDataToDyad(DyadData data) {
    return Dyad(
      id: data.id,
      userId: data.userId ?? "",
      collectivityId: data.collectivityId,
      status: Status.fromString(data.status),
      type: CollectivityType.dyad,
    );
  }

  Stream<List<Collectivity>> watchCollectivities() {
    final db = database;
    final query = db.select(db.collectivities).join([
      drift.leftOuterJoin(db.groups, db.groups.collectivityId.equalsExp(db.collectivities.collectivityId)),
      drift.leftOuterJoin(db.dyad, db.dyad.collectivityId.equalsExp(db.collectivities.collectivityId)),
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        final groupData = row.readTableOrNull(db.groups);
        final dyadData = row.readTableOrNull(db.dyad);

        if (groupData != null) {
          return _mapGroupDataToGroup(groupData);
        } else if (dyadData != null) {
          return _mapDyadDataToDyad(dyadData);
        }
        return null;
      }).whereType<Collectivity>().toList();
    });
  }

  Stream<List<Collectivity>> watchUnsyncedCollectivities() {
    final db = database;
    final query = db.select(db.collectivities).join([
      drift.leftOuterJoin(db.groups, db.groups.collectivityId.equalsExp(db.collectivities.collectivityId)),
      drift.leftOuterJoin(db.dyad, db.dyad.collectivityId.equalsExp(db.collectivities.collectivityId)),
    ]);
    
    query.where(
        db.groups.status.equals(Status.created.name) | 
        db.dyad.status.equals(Status.created.name)
    );

    return query.watch().map((rows) {
      return rows.map((row) {
        final groupData = row.readTableOrNull(db.groups);
        final dyadData = row.readTableOrNull(db.dyad);

        if (groupData != null && groupData.status == Status.created.name) {
          return _mapGroupDataToGroup(groupData);
        } else if (dyadData != null && dyadData.status == Status.created.name) {
          return _mapDyadDataToDyad(dyadData);
        }
        return null;
      }).whereType<Collectivity>().toList();
    });
  }

  Future<void> checkPendingCollectivitiesTimeout() async {
    final db = database;
    final timeoutThreshold = DateTime.now().subtract(const Duration(minutes: 1));
    
    await (db.update(db.groups)
      ..where((tbl) => tbl.status.equals(Status.pending.name) & tbl.createdAt.isSmallerThanValue(timeoutThreshold)))
      .write(GroupsCompanion(status: drift.Value(Status.failed.name)));

    await (db.update(db.dyad)
      ..where((tbl) => tbl.status.equals(Status.pending.name) & tbl.createdAt.isSmallerThanValue(timeoutThreshold)))
      .write(DyadCompanion(status: drift.Value(Status.failed.name)));
  }

  Future<void> insert(Collectivity collectivity) async {
    final db = database;
    await db.transaction(() async {
      await db.into(db.collectivities).insert(
        CollectivitiesCompanion.insert(
          collectivityId: collectivity.collectivityId ?? '',
        ),
        mode: drift.InsertMode.insertOrReplace,
      );

      if (collectivity is Group) {
        await db.into(db.groups).insert(
          GroupsCompanion.insert(
            collectivityId: drift.Value(collectivity.collectivityId),
            name: drift.Value(collectivity.name),
            creatorId: drift.Value(collectivity.creatorId),
            imageId: drift.Value(collectivity.imageId),
            status: drift.Value(collectivity.status.name),
          ),
          mode: drift.InsertMode.insertOrReplace,
        );
      } else if (collectivity is Dyad) {
        await db.into(db.dyad).insert(
          DyadCompanion.insert(
            collectivityId: drift.Value(collectivity.collectivityId),
            userId: drift.Value(collectivity.userId),
            status: drift.Value(collectivity.status.name),
          ),
          mode: drift.InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<void> insertCollectivityList(List<Collectivity> collectivities) async {
    final db = database;
    await db.transaction(() async {
      for (final collectivity in collectivities) {
        await insert(collectivity);
      }
    });
  }

  Future<void> updateGroup(Group group) async {
    final db = database;
    
    await (db.update(db.groups)..where((tbl) => tbl.collectivityId.equals(group.collectivityId!))).write(
      GroupsCompanion(
        name: drift.Value(group.name),
        creatorId: drift.Value(group.creatorId),
        imageId: drift.Value(group.imageId),
        status: drift.Value(group.status.name),
      ),
    );
  }


  Future<void> updateDyad(Dyad dyad) async {
    final db = database;
    await (db.update(db.dyad)..where((tbl) => tbl.collectivityId.equals(dyad.collectivityId!))).write(
      DyadCompanion(
        userId: drift.Value(dyad.userId),
        status: drift.Value(dyad.status.name),
      ),
    );
  }

  Future<void> createCollectivityIfNotExist(String collectivityId)async{
    int a=await isExistByCollectivityIdId(collectivityId);
    if(a==0){
      Group group=Group(collectivityId: collectivityId);
      await insert(group);
    }
  }

  Future<int> isExistByCollectivityIdId(String collectivityId) async {
    final db = database;
    final count = await (db.select(db.collectivities)..where((tbl) => tbl.collectivityId.equals(collectivityId))).get();
    return count.length;
  }


  Future<Dyad?> getDyadByUserId(String userId) async {
    final db = database;
    final row = await (db.select(db.dyad)..where((tbl) => tbl.userId.equals(userId))).getSingleOrNull();
    return row != null ? _mapDyadDataToDyad(row) : null;
  }

  Future<List<Collectivity>> getUnsyncedCollectivities() async {
    final db = database;
    
    final groups = await (db.select(db.groups)..where((tbl) => tbl.status.equals(Status.created.name))).get();
    final dyads = await (db.select(db.dyad)..where((tbl) => tbl.status.equals(Status.created.name))).get();
    
    List<Collectivity> result = [];
    result.addAll(groups.map(_mapGroupDataToGroup));
    result.addAll(dyads.map(_mapDyadDataToDyad));
    
    return result;
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
