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

  Stream<List<Message>> watchUnsyncedCollectivityMessages() {
    final db = database;
    
    return db.customSelect(
      'SELECT * FROM ${DbTableNames.messages} WHERE status != \'SYNC\' AND collectivity_id IS NOT NULL',
      readsFrom: {db.messages},
    ).watch().map((rows) => 
      rows.map((row) => Message.fromDb(row.data)).toList()
    );
  }

  Future<void> insertMessage(Message message) async {
    final db = database;
    final map = message.toDb();
    await db.customInsert(
      'INSERT OR REPLACE INTO ${DbTableNames.messages} '
      '(message_id, message, user_id, collectivity_id, dyad_receiver_id, send_time, status) '
      'VALUES (?, ?, ?, ?, ?, ?, ?)',
      variables: [
        drift.Variable.withString(map['message_id'] ?? ''),
        drift.Variable.withString(map['message'] ?? ''),
        drift.Variable.withString(map['user_id'] ?? ''),
        drift.Variable.withString(map['collectivity_id'] ?? ''),
        drift.Variable.withString(map['dyad_receiver_id'] ?? ''),
        drift.Variable.withInt(map['send_time'] ?? 0),
        drift.Variable.withString(map['status'] ?? ''),
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
        '(message_id, message, user_id, collectivity_id, dyad_receiver_id, send_time, status) '
        'VALUES (?, ?, ?, ?, ?, ?, ?)',
        variables: [
          drift.Variable.withString(map['message_id'] ?? ''),
          drift.Variable.withString(map['message'] ?? ''),
          drift.Variable.withString(map['user_id'] ?? ''),
          drift.Variable.withString(map['collectivity_id'] ?? ''),
          drift.Variable.withString(map['dyad_receiver_id'] ?? ''),
          drift.Variable.withInt(map['send_time'] ?? 0),
          drift.Variable.withString(map['status'] ?? ''),
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
      'message_id = ?, message = ?, user_id = ?, collectivity_id = ?, '
      'dyad_receiver_id = ?, send_time = ?, status = ? WHERE id = ?',
      variables: [
        drift.Variable.withString(map['message_id'] ?? ''),
        drift.Variable.withString(map['message'] ?? ''),
        drift.Variable.withString(map['user_id'] ?? ''),
        drift.Variable.withString(map['collectivity_id'] ?? ''),
        drift.Variable.withString(map['dyad_receiver_id'] ?? ''),
        drift.Variable.withInt(map['send_time'] ?? 0),
        drift.Variable.withString(map['status'] ?? ''),
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
      'message_id = ?, message = ?, user_id = ?, collectivity_id = ?, '
      'dyad_receiver_id = ?, send_time = ?, status = ? WHERE id = ?',
      variables: [
        drift.Variable.withString(map['message_id'] ?? ''),
        drift.Variable.withString(map['message'] ?? ''),
        drift.Variable.withString(map['user_id'] ?? ''),
        drift.Variable.withString(map['collectivity_id'] ?? ''),
        drift.Variable.withString(map['dyad_receiver_id'] ?? ''),
        drift.Variable.withInt(map['send_time'] ?? 0),
        drift.Variable.withString(map['status'] ?? ''),
        drift.Variable.withInt(map['id']),
      ],
      updates: {db.messages},
    );
  }

  Future<void> batchFixCollectivityIdJob(String collectivityId, String userId) async {
    final db = database;
    await db.customUpdate(
      'UPDATE ${DbTableNames.messages} SET collectivity_id = ?, dyad_receiver_id = NULL WHERE dyad_receiver_id = ?',
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
      'SELECT * FROM ${DbTableNames.messages} WHERE collectivity_id = ? OR dyad_receiver_id = ?',
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
      'SELECT * FROM ${DbTableNames.messages} WHERE status != \'SYNC\' AND collectivity_id IS NOT NULL',
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

