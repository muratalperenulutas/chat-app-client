import 'package:chat_app/constants/db/table_names.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/general_change_notifier.dart';
import '../database_service.dart';
import 'group_participant.dart';

class GroupParticipantRepository {
  final DatabaseService databaseService=Get.find<DatabaseService>();
  GeneralChangeNotifier generalChangeNotifier=Get.find<GeneralChangeNotifier>();
  Future<Database> get database async => databaseService.getDatabase();

  Future<void> insertGroupParticipant(GroupParticipant participant) async {
    final db = await database;
    await db.insert(DbTableNames.groupParticipants, participant.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    generalChangeNotifier.groupParticipantsChanged();
  }
}
