import 'package:chat_app/constants/enums/status.dart';
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

  Message _mapMessageDataToMessage(MessageData data) {
    return Message(
      id: data.id,
      messageId: data.messageId,
      message: data.message,
      collectivityId: data.collectivityId,
      dyadReceiverId: data.dyadReceiverId,
      userId: data.userId,
      sendTime: data.sendTime ?? DateTime.now(),
      status: Status.fromString(data.status),
    );
  }

  Stream<List<Message>> watchMessagesByCollectivityIdOrDyadReceiverId(String collectivityId, String dyadReceiverId) {
    final db = database;
    return (db.select(db.messages)
      ..where((tbl) => tbl.collectivityId.equals(collectivityId) | tbl.dyadReceiverId.equals(dyadReceiverId)))
      .watch()
      .map((rows) => List<MessageData>.from(rows).map(_mapMessageDataToMessage).toList());
  }

  Stream<List<Message>> watchUnsyncedCollectivityMessages() {
    final db = database;
    return (db.select(db.messages)
      ..where((tbl) => tbl.status.isNotValue('SYNC') & tbl.collectivityId.isNotNull()))
      .watch()
      .map((rows) => List<MessageData>.from(rows).map(_mapMessageDataToMessage).toList());
  }

  Future<void> insertMessage(Message message) async {
    final db = database;
    await db.into(db.messages).insert(
      MessagesCompanion.insert(
        messageId: message.messageId ?? '',
        message: message.message,
        userId: message.userId,
        collectivityId: drift.Value(message.collectivityId),
        dyadReceiverId: drift.Value(message.dyadReceiverId),
        sendTime: drift.Value(message.sendTime),
        status: drift.Value(message.status.name),
      ),
      mode: drift.InsertMode.insertOrReplace,
    );
  }

  Future<void> insertMessageList(List<Message> messages) async {
    final db = database;
    await db.batch((batch) {
      batch.insertAll(
        db.messages,
        messages.map((message) => MessagesCompanion.insert(
          messageId: message.messageId ?? '',
          message: message.message,
          userId: message.userId,
          collectivityId: drift.Value(message.collectivityId),
          dyadReceiverId: drift.Value(message.dyadReceiverId),
          sendTime: drift.Value(message.sendTime),
          status: drift.Value(message.status.name),
        )),
        mode: drift.InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> updateMessage(Message message) async {
    final db = database;
    await (db.update(db.messages)..where((tbl) => tbl.id.equals(message.id!))).write(
      MessagesCompanion(
        messageId: drift.Value(message.messageId ?? ''),
        message: drift.Value(message.message),
        userId: drift.Value(message.userId),
        collectivityId: drift.Value(message.collectivityId),
        dyadReceiverId: drift.Value(message.dyadReceiverId),
        sendTime: drift.Value(message.sendTime),
        status: drift.Value(message.status.name),
      ),
    );
  }


  Future<void> batchFixCollectivityIdJob(String collectivityId, String userId) async {
    final db = database;
    await (db.update(db.messages)..where((tbl) => tbl.dyadReceiverId.equals(userId))).write(
      MessagesCompanion(
        collectivityId: drift.Value(collectivityId),
        dyadReceiverId: const drift.Value(null),
      ),
    );
  }

  Future<List<Message>> getMessagesByCollectivityIdOrDyadReceiverId(String collectivityId, String dyadReceiverId) async {
    final db = database;
    final rows = await (db.select(db.messages)
      ..where((tbl) => tbl.collectivityId.equals(collectivityId) | tbl.dyadReceiverId.equals(dyadReceiverId)))
      .get();
    return rows.map(_mapMessageDataToMessage).toList();
  }

  Future<List<Message>> getAllUnsyncedMessages() async {
    final db = database;
    final rows = await (db.select(db.messages)..where((tbl) => tbl.status.equals('CREATED'))).get();
    return rows.map(_mapMessageDataToMessage).toList();
  }

  Future<List<Message>> getAllUnsyncedCollectivityMessages() async {
    final db = database;
    final rows = await (db.select(db.messages)
      ..where((tbl) => tbl.status.isNotValue('SYNC') & tbl.collectivityId.isNotNull()))
      .get();
    return rows.map(_mapMessageDataToMessage).toList();
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

