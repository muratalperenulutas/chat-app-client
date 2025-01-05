import 'package:chat_app/constants/db/table_names.dart';
import 'package:chat_app/data/group_participant/group_participant.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/general_change_notifier.dart';
import '../database_service.dart';

class GroupParticipantRepository {
  final DatabaseService databaseService=Get.find<DatabaseService>();
  GeneralChangeNotifier generalChangeNotifier=Get.find<GeneralChangeNotifier>();
  Future<Database> get database async => databaseService.getDatabase();

  Future<void> insertGroupParticipant(GroupParticipantModel participant) async {
    final db = await database;
    await db.insert(DbTableNames.groupParticipantsTableName, participant.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    generalChangeNotifier.groupParticipantsChanged();
  }
}
