import 'package:chat_app/constants/db/table_names.dart';
import 'package:chat_app/data/database/database.dart';
import 'package:drift/drift.dart' as drift;
import 'package:get/get.dart';

import '../../core/general_change_notifier.dart';
import '../database_service.dart';
import 'message.dart';

class MessageRepository {
  final DatabaseService databaseService = Get.find<DatabaseService>();

  AppDatabase get database => databaseService.getDatabase();
  GeneralChangeNotifier generalChangeNotifier =
      Get.find<GeneralChangeNotifier>();

  Future<void> insertMessage(Message message) async {
    final db = database;
    final map = message.toDb();
    await db.customInsert(
      'INSERT OR REPLACE INTO ${DbTableNames.messages} '
      '(id, messageId, message, userId, collectivityId, dyadReceiverId, sendTime, status) '
      'VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      variables: [
        drift.Variable.withInt(map['id']),
        drift.Variable.withString(map['messageId']),
        drift.Variable.withString(map['message']),
        drift.Variable.withString(map['userId']),
        drift.Variable.withString(map['collectivityId']),
        drift.Variable.withString(map['dyadReceiverId']),
        drift.Variable.withString(map['sendTime']),
        drift.Variable.withString(map['status']),
      ],
      updates: {db.messages},
    );
    generalChangeNotifier.messagesChanged();
  }

  Future<void> insertMessageList(List<Message> messages) async {
    final db = database;
    for (var message in messages) {
      final map = message.toDb();
      await db.customInsert(
        'INSERT OR REPLACE INTO ${DbTableNames.messages} '
        '(id, messageId, message, userId, collectivityId, dyadReceiverId, sendTime, status) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        variables: [
          drift.Variable.withInt(map['id']),
          drift.Variable.withString(map['messageId']),
          drift.Variable.withString(map['message']),
          drift.Variable.withString(map['userId']),
          drift.Variable.withString(map['collectivityId']),
          drift.Variable.withString(map['dyadReceiverId']),
          drift.Variable.withString(map['sendTime']),
          drift.Variable.withString(map['status']),
        ],
        updates: {db.messages},
      );
    }
    generalChangeNotifier.messagesChanged();
  }

  Future<void> updateMessage(Message message) async {
    final db = database;
    final map = message.toDb();
    await db.customUpdate(
      'UPDATE ${DbTableNames.messages} SET '
      'messageId = ?, message = ?, userId = ?, collectivityId = ?, '
      'dyadReceiverId = ?, sendTime = ?, status = ? WHERE id = ?',
      variables: [
        drift.Variable.withString(map['messageId']),
        drift.Variable.withString(map['message']),
        drift.Variable.withString(map['userId']),
        drift.Variable.withString(map['collectivityId']),
        drift.Variable.withString(map['dyadReceiverId']),
        drift.Variable.withString(map['sendTime']),
        drift.Variable.withString(map['status']),
        drift.Variable.withInt(map['id']),
      ],
      updates: {db.messages},
    );
    generalChangeNotifier.messagesChanged();
  }

  Future<void> updateMessageWithoutNotifier(Message message) async {
    final db = database;
    final map = message.toDb();
    await db.customUpdate(
      'UPDATE ${DbTableNames.messages} SET '
      'messageId = ?, message = ?, userId = ?, collectivityId = ?, '
      'dyadReceiverId = ?, sendTime = ?, status = ? WHERE id = ?',
      variables: [
        drift.Variable.withString(map['messageId']),
        drift.Variable.withString(map['message']),
        drift.Variable.withString(map['userId']),
        drift.Variable.withString(map['collectivityId']),
        drift.Variable.withString(map['dyadReceiverId']),
        drift.Variable.withString(map['sendTime']),
        drift.Variable.withString(map['status']),
        drift.Variable.withInt(map['id']),
      ],
      updates: {db.messages},
    );
  }

  Future<void> batchFixCollectivityIdJob(String collectivityId, String userId) async {
    final db = database;
    await db.customUpdate(
      'UPDATE ${DbTableNames.messages} SET collectivityId = ?, dyadReceiverId = NULL WHERE dyadReceiverId = ?',
      variables: [
        drift.Variable.withString(collectivityId),
        drift.Variable.withString(userId),
      ],
      updates: {db.messages},
    );
    generalChangeNotifier.messagesChanged();
  }

  Future<List<Message>> getMessagesByCollectivityIdOrDyadReceiverId(String collectivityId, String dyadReceiverId) async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.messages} WHERE collectivityId = ? OR dyadReceiverId = ?',
      variables: [
        drift.Variable.withString(collectivityId),
        drift.Variable.withString(dyadReceiverId),
      ],
      readsFrom: {db.messages},
    );
    
    final results = await query.get();
    return results.map((row) => Message.fromDb(row.data)).toList();
  }

  Future<List<Message>> getAllUnsyncedMessages() async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.messages} WHERE status = "CREATED"',
      readsFrom: {db.messages},
    );
    
    final results = await query.get();
    return results.map((row) => Message.fromDb(row.data)).toList();
  }

  Future<List<Message>> getAllUnsyncedCollectivityMessages() async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.messages} WHERE status != \'SYNC\' AND collectivityId IS NOT NULL',
      readsFrom: {db.messages},
    );
    
    final results = await query.get();
    print("UnsyncedCollectivityMessages ${results.map((r) => r.data).toList()}");
    return results.map((row) => Message.fromDb(row.data)).toList();
  }

  Future<void> printAll() async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.messages}',
      readsFrom: {db.messages},
    );
    
    final results = await query.get();
    print(results.map((r) => r.data).toList());
  }
}

