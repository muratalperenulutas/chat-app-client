import 'package:chat_app/constants/db/table_names.dart';
import 'package:chat_app/core/di/injection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../database_service.dart';
import '../database/database.dart';
import 'participant.dart';

@singleton
class ParticipantRepository {
  final DatabaseService databaseService = getIt<DatabaseService>();
  AppDatabase get database => databaseService.getDatabase();

  Future<void> insertParticipant(Participant participant) async {
    final db = database;
    await db.customInsert(
      'INSERT OR REPLACE INTO ${DbTableNames.participants} '
      '(user_id, collectivity_id) VALUES (?, ?)',
      variables: [
        drift.Variable.withString(participant.userId ?? ''),
        drift.Variable.withString(participant.collectivityId ?? ''),
      ],
      updates: {db.participants},
    );
  }

  Future<void> insertParticipantList(List<Participant> participants) async {
    final db = database;
    for (var participant in participants) {
      try {
        await db.customInsert(
          'INSERT INTO ${DbTableNames.participants} '
          '(user_id, collectivity_id) VALUES (?, ?)',
          variables: [
            drift.Variable.withString(participant.userId ?? ''),
            drift.Variable.withString(participant.collectivityId ?? ''),
          ],
          updates: {db.participants},
        );
      } catch (e) {
        // Skip on conflict
        debugPrint("Error inserting participant: $e");
      }
    }
  }

  Participant _mapRowToParticipant(drift.QueryRow row) {
    return Participant(
      id: row.read<int>('id'),
      userId: row.read<String?>('user_id'),
      collectivityId: row.read<String?>('collectivity_id'),
    );
  }

  Future<List<Participant>> getAllParticipants(String collectivityId) async {
    // printAll();
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.participants} WHERE collectivity_id = ?',
      variables: [drift.Variable.withString(collectivityId)],
      readsFrom: {db.participants},
    );
    
    final results = await query.get();
    return results.map(_mapRowToParticipant).toList();
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
