import 'dart:async';
import 'package:chat_app/models/group.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static const int _version = 1;
  static const String _dbName = "ChatApp.db"; //ChatApp?UserId?324.db
  static int? userId;
  static Database? _database; 

  static const String messagesTableName = "messages";
  static const String groupParticipantsTableName = "groupParticipants";
  static const String groupsTableName = "groups";

  static Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user-id');
  }

  static Future<Database> _getDatabase() async {
    if (_database != null) return _database!;

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dbName);

    _database = await openDatabase(path, version: _version,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS $groupsTableName (id INTEGER PRIMARY KEY, name TEXT NOT NULL, groupId INTEGER NOT NULL, isDirectChat INTEGER DEFAULT 0)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS $groupParticipantsTableName (id INTEGER PRIMARY KEY, groupId INTEGER NOT NULL, participantId INTEGER NOT NULL)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS $messagesTableName (id INTEGER PRIMARY KEY, messageId INTEGER, message TEXT NOT NULL, senderId INTEGER NOT NULL, groupId INTEGER NOT NULL, isSend INTEGER DEFAULT 0)');
    });
    return _database!;
  }

  static Future<void> insertMessage(Map<String, dynamic> data) async {
    final db = await _getDatabase();
    await db.insert(messagesTableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> insertGroupParticipant(Map<String, dynamic> data) async {
    final db = await _getDatabase();
    await db.insert(groupParticipantsTableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> insertGroup(Map<String, dynamic> data) async {
    final db = await _getDatabase();
    await db.insert(groupsTableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getMessagesFromGroup(
      String groupId) async {
    final db = await _getDatabase();
    final list = await db.rawQuery(
        'SELECT * FROM $messagesTableName WHERE groupId = ?', [groupId]);
    return list;
  }

  static Future<List<GroupModel>> getGroups() async {
    final db = await _getDatabase();
    final list = await db.rawQuery('SELECT * FROM $groupsTableName');
    return list.map((map) => GroupModel.fromDb(map)).toList();
  }

  static Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null; 
    }
  }
}
