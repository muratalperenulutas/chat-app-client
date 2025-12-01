import 'package:chat_app/constants/enums/status.dart';
import 'package:chat_app/constants/db/table_names.dart';
import 'package:chat_app/data/database/database.dart';
import 'package:drift/drift.dart' as drift;
import 'package:injectable/injectable.dart';

import '../database_service.dart';
import 'message.dart';

@singleton
class MessageRepository {
  final DatabaseService databaseService;

  MessageRepository(this.databaseService);

  AppDatabase get database => databaseService.getDatabase();

  Message _mapRowToMessage(drift.QueryRow row) {
    return Message(
      id: row.read<int>('id'),
      messageId: row.read<String?>('message_id'),
      message: row.read<String>('message'),
      collectivityId: row.read<String?>('collectivity_id'),
      dyadReceiverId: row.read<String?>('dyad_receiver_id'),
      userId: row.read<String>('user_id'),
      sendTime: DateTime.fromMillisecondsSinceEpoch(row.read<int>('send_time')),
      status: Status.fromString(row.read<String>('status')),
    );
  }

  Stream<List<Message>> watchUnsyncedCollectivityMessages() {
    final db = database;
    
    return db.customSelect(
      'SELECT * FROM ${DbTableNames.messages} WHERE status != \'SYNC\' AND collectivity_id IS NOT NULL',
      readsFrom: {db.messages},
    ).watch().map((rows) => 
      rows.map(_mapRowToMessage).toList()
    );
  }

  Future<void> insertMessage(Message message) async {
    final db = database;
    await db.customInsert(
      'INSERT OR REPLACE INTO ${DbTableNames.messages} '
      '(message_id, message, user_id, collectivity_id, dyad_receiver_id, send_time, status) '
      'VALUES (?, ?, ?, ?, ?, ?, ?)',
      variables: [
        drift.Variable.withString(message.messageId ?? ''),
        drift.Variable.withString(message.message),
        drift.Variable.withString(message.userId),
        drift.Variable.withString(message.collectivityId ?? ''),
        drift.Variable.withString(message.dyadReceiverId ?? ''),
        drift.Variable.withInt(message.sendTime.millisecondsSinceEpoch),
        drift.Variable.withString(message.status.name),
      ],
      updates: {db.messages},
    );
  }

  Future<void> insertMessageList(List<Message> messages) async {
    final db = database;
    for (var message in messages) {
      await db.customInsert(
        'INSERT OR REPLACE INTO ${DbTableNames.messages} '
        '(message_id, message, user_id, collectivity_id, dyad_receiver_id, send_time, status) '
        'VALUES (?, ?, ?, ?, ?, ?, ?)',
        variables: [
          drift.Variable.withString(message.messageId ?? ''),
          drift.Variable.withString(message.message),
          drift.Variable.withString(message.userId),
          drift.Variable.withString(message.collectivityId ?? ''),
          drift.Variable.withString(message.dyadReceiverId ?? ''),
          drift.Variable.withInt(message.sendTime.millisecondsSinceEpoch),
          drift.Variable.withString(message.status.name),
        ],
        updates: {db.messages},
      );
    }
  }

  Future<void> updateMessage(Message message) async {
    final db = database;
    await db.customUpdate(
      'UPDATE ${DbTableNames.messages} SET '
      'message_id = ?, message = ?, user_id = ?, collectivity_id = ?, '
      'dyad_receiver_id = ?, send_time = ?, status = ? WHERE id = ?',
      variables: [
        drift.Variable.withString(message.messageId ?? ''),
        drift.Variable.withString(message.message),
        drift.Variable.withString(message.userId),
        drift.Variable.withString(message.collectivityId ?? ''),
        drift.Variable.withString(message.dyadReceiverId ?? ''),
        drift.Variable.withInt(message.sendTime.millisecondsSinceEpoch),
        drift.Variable.withString(message.status.name),
        drift.Variable.withInt(message.id!),
      ],
      updates: {db.messages},
    );
  }

  Future<void> updateMessageWithoutNotifier(Message message) async {
    final db = database;
    await db.customUpdate(
      'UPDATE ${DbTableNames.messages} SET '
      'message_id = ?, message = ?, user_id = ?, collectivity_id = ?, '
      'dyad_receiver_id = ?, send_time = ?, status = ? WHERE id = ?',
      variables: [
        drift.Variable.withString(message.messageId ?? ''),
        drift.Variable.withString(message.message),
        drift.Variable.withString(message.userId),
        drift.Variable.withString(message.collectivityId ?? ''),
        drift.Variable.withString(message.dyadReceiverId ?? ''),
        drift.Variable.withInt(message.sendTime.millisecondsSinceEpoch),
        drift.Variable.withString(message.status.name),
        drift.Variable.withInt(message.id!),
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
    return results.map(_mapRowToMessage).toList();
  }

  Future<List<Message>> getAllUnsyncedMessages() async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.messages} WHERE status = "CREATED"',
      readsFrom: {db.messages},
    );
    
    final results = await query.get();
    return results.map(_mapRowToMessage).toList();
  }

  Future<List<Message>> getAllUnsyncedCollectivityMessages() async {
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.messages} WHERE status != \'SYNC\' AND collectivity_id IS NOT NULL',
      readsFrom: {db.messages},
    );
    
    final results = await query.get();
    return results.map(_mapRowToMessage).toList();
  }

  Future<void> printAll() async {
    /*
    final db = database;
    final query = db.customSelect(
      'SELECT * FROM ${DbTableNames.messages}',
      readsFrom: {db.messages},
    );
    
    final results = await query.get();
    debugPrint(results.map((r) => r.data).toList().toString());
    */
  }
}

