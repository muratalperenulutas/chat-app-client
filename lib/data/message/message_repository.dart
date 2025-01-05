import 'package:chat_app/constants/db/table_names.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/general_change_notifier.dart';
import '../database_service.dart';
import 'message.dart';

class MessageRepository {
  final DatabaseService databaseService=Get.find<DatabaseService>();
  Future<Database> get database async => databaseService.getDatabase();
  GeneralChangeNotifier generalChangeNotifier=Get.find<GeneralChangeNotifier>();


  Future<int> insertMessage(MessageModel messageModel) async {
    final db = await database;
    int id=await db.insert(DbTableNames.messagesTableName, messageModel.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace); //returns id of row
    generalChangeNotifier.messagesChanged();
    return id;
  }
  Future<int> updateMessage(
      int messageId, MessageModel messageModel) async {
    final db = await database;
    int id=await db.update(
      DbTableNames.messagesTableName,
      messageModel.toDb(),
      where: 'id = ?',
      whereArgs: [messageId],
    );
    generalChangeNotifier.messagesChanged();
    return id;
  }
  Future<List<MessageModel>> getMessagesFromGroupById(int id) async {
    final db = await database;
    final list = await db.rawQuery(
        'SELECT * FROM ${DbTableNames.messagesTableName} WHERE localGroupId = ?', [id]);
    return list.map((map) => MessageModel.fromDb(map)).toList();
  }

}
