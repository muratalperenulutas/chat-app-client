import 'package:chat_app/core/di/injection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:injectable/injectable.dart';

import '../database_service.dart';
import '../database/database.dart';
import 'participant.dart';

@singleton
class ParticipantRepository {
  final DatabaseService databaseService = getIt<DatabaseService>();
  AppDatabase get database => databaseService.getDatabase();

  Participant _mapParticipantDataToParticipant(ParticipantData data) {
    return Participant(
      id: data.id,
      userId: data.userId,
      collectivityId: data.collectivityId,
    );
  }

  Future<void> insertParticipant(Participant participant) async {
    final db = database;
    await db.into(db.participants).insert(
      ParticipantsCompanion.insert(
        userId: participant.userId ?? '',
        collectivityId: drift.Value(participant.collectivityId),
      ),
      mode: drift.InsertMode.insertOrReplace,
    );
  }

  Future<void> insertParticipantList(List<Participant> participants) async {
    final db = database;
    await db.batch((batch) {
      batch.insertAll(
        db.participants,
        participants.map((participant) => ParticipantsCompanion.insert(
          userId: participant.userId ?? '',
          collectivityId: drift.Value(participant.collectivityId),
        )),
        mode: drift.InsertMode.insertOrReplace, // Or ignore if that was the intent
      );
    });
  }

  Future<List<Participant>> getAllParticipants(String collectivityId) async {
    // printAll();
    final db = database;
    final rows = await (db.select(db.participants)..where((tbl) => tbl.collectivityId.equals(collectivityId))).get();
    return List<ParticipantData>.from(rows).map(_mapParticipantDataToParticipant).toList();
  }

  Future<void> printAll() async {
    /*
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.participants}',
      readsFrom: {db.participants},
    );
    
    final results = await query.get();
    debugPrint(results.map((r) => r.data).toList().toString());
    */
  }
}
