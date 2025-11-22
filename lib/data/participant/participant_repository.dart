import 'package:chat_app/constants/db/table_names.dart';
import 'package:get/get.dart';
import 'package:drift/drift.dart' as drift;

import '../../core/general_change_notifier.dart';
import '../database_service.dart';
import '../database/database.dart';
import 'participant.dart';

class ParticipantRepository {
  final DatabaseService databaseService=Get.find<DatabaseService>();
  GeneralChangeNotifier generalChangeNotifier=Get.find<GeneralChangeNotifier>();
  AppDatabase get database => databaseService.getDatabase();

  Future<void> insertParticipant(Participant participant) async {
    final db = database;
    final map = participant.toDb();
    await db.customInsert(
      'INSERT OR REPLACE INTO ${DbTableNames.participants} '
      '(user_id, collectivity_id) VALUES (?, ?)',
      variables: [
        drift.Variable.withString(map['user_id'] ?? ''),
        drift.Variable.withString(map['collectivity_id'] ?? ''),
      ],
      updates: {db.participants},
    );
    generalChangeNotifier.groupParticipantsChanged();
  }

  Future<void> insertParticipantList(List<Participant> participants) async {
    final db = database;
    for (var participant in participants) {
      final map = participant.toDb();
      try {
        await db.customInsert(
          'INSERT INTO ${DbTableNames.participants} '
          '(user_id, collectivity_id) VALUES (?, ?)',
          variables: [
            drift.Variable.withString(map['user_id'] ?? ''),
            drift.Variable.withString(map['collectivity_id'] ?? ''),
          ],
          updates: {db.participants},
        );
      } catch (e) {
        // Skip on conflict
        print("Error inserting participant: $e");
      }
    }
    generalChangeNotifier.groupParticipantsChanged();
  }

  Future<List<Participant>> getAllParticipants(String collectivityId) async {
    printAll();
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.participants} WHERE collectivity_id = ?',
      variables: [drift.Variable.withString(collectivityId)],
      readsFrom: {db.participants},
    );
    
    final results = await query.get();
    return results.map((row) => Participant.fromDb(row.data)).toList();
  }

  Future<void> printAll() async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.participants}',
      readsFrom: {db.participants},
    );
    
    final results = await query.get();
    print(results.map((r) => r.data).toList());
  }
}
