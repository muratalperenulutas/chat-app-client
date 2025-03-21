import 'package:chat_app/constants/db/table_names.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/general_change_notifier.dart';
import '../database_service.dart';
import 'message.dart';

class MessageRepository {
  final DatabaseService databaseService = Get.find<DatabaseService>();

  Future<Database> get database async => databaseService.getDatabase();
  GeneralChangeNotifier generalChangeNotifier =
      Get.find<GeneralChangeNotifier>();

  Future<void> insertMessage(Message message) async {
    final db = await database;
    await db.insert(DbTableNames.messages, message.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    generalChangeNotifier.messagesChanged();
  }

  Future<void> updateMessage(int messageId, Message message) async {
    final db = await database;
    await db.update(
      DbTableNames.messages,
      message.toDb(),
      where: 'id = ?',
      whereArgs: [messageId],
    );
    generalChangeNotifier.messagesChanged();
  }

  Future<void> batchFixCollectivityIdJob(int collectivityId, String userId) async {
    final db = await database;
    await db.rawUpdate(
      'UPDATE ${DbTableNames.messages} SET collectivityId = ? WHERE dyadReceiverId = ?',
      [collectivityId, userId],
    );
    generalChangeNotifier.messagesChanged();
  }

  Future<List<Message>> getMessagesByCollectivityIdOrDyadReceiverId(int collectivityId, String dyadReceiverId) async {
    final db = await database;
    final list = await db.rawQuery(
        'SELECT * FROM ${DbTableNames.messages} WHERE collectivityId = ? OR dyadReceiverId = ?',
        [collectivityId, dyadReceiverId]
    );
    return list.map((map) => Message.fromDb(map)).toList();
  }

  Future<List<Message>> getAllUnsyncedMessages() async {
    final db = await database;
    final list = await db.rawQuery(
        'SELECT * FROM ${DbTableNames.messages} WHERE status = "CREATED"');
    return list.map((map) => Message.fromDb(map)).toList();
  }
  Future<List<Message>> getAllUnsyncedCollectivityMessages() async {
    final db = await database;
    final list = await db.rawQuery(
        'SELECT * FROM ${DbTableNames.messages} WHERE status != \'SYNC\' AND collectivityId IS NOT NULL'
    );
    print("UnsyncedCollectivityMessages $list");
    return list.map((map) => Message.fromDb(map)).toList();
  }

  Future<void> printAll() async {
    final db = await database;
    final list = await db.rawQuery(
        'SELECT * FROM ${DbTableNames.messages}');
    print(list);
  }

}
