import 'package:chat_app/constants/db/table_names.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/general_change_notifier.dart';
import '../database_service.dart';
import 'participant.dart';

class ParticipantRepository {
  final DatabaseService databaseService=Get.find<DatabaseService>();
  GeneralChangeNotifier generalChangeNotifier=Get.find<GeneralChangeNotifier>();
  Future<Database> get database async => databaseService.getDatabase();

  Future<void> insertParticipant(Participant participant) async {
    final db = await database;
    await db.insert(DbTableNames.participants, participant.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    generalChangeNotifier.groupParticipantsChanged();
  }
  Future<void> insertParticipantList(List<Participant> participants) async {
    final db = await database;

    Batch batch = db.batch();
    for (var participant in participants) {
      batch.insert(
        DbTableNames.participants,
        participant.toDb(),
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
    }

    await batch.commit(noResult: true);
    generalChangeNotifier.groupParticipantsChanged();
  }

  Future<List<Participant>> getAllParticipants(int collectivityId) async {
    printAll();
    final db = await database;
    final list = await db.rawQuery(
      'SELECT * FROM ${DbTableNames.participants} WHERE collectivityId = ?',
      [collectivityId],
    );
    return list.map((map) => Participant.fromDb(map)).toList();
  }
  Future<void> printAll() async {
    final db = await database;
    final list = await db.rawQuery(
      'SELECT * FROM ${DbTableNames.participants} ',
    );
    print(list);
  }
}
