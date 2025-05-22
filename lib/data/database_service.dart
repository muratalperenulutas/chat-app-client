import 'dart:async';
import 'package:chat_app/constants/db/table_names.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService extends GetxService {
  final int _version = 1;
  final String _dbName = "ChatApp.db"; //ChatApp?UserId?324.db
  Database? _database;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initializeDatabase();
  }

  Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    return await _initializeDatabase();
  }

  Future<Database> _initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dbName);
    _database = await openDatabase(path, version: _version,
        onCreate: (Database db, int version) async {
      await db.execute('PRAGMA foreign_keys = ON');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS ${DbTableNames.collectivity} ('
          'id INTEGER PRIMARY KEY, '
          'collectivityId TEXT UNIQUE,'
          'name TEXT, '
          'creatorId TEXT, '
          'description TEXT, '
          'imageId TEXT ,'
          'collectivityType TEXT,'
          'userId TEXT,'
          'status TEXT DEFAULT \'CREATED\')');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS ${DbTableNames.participants} ('
          'id INTEGER PRIMARY KEY, '
          'userId TEXT NOT NULL, '
          'collectivityId TEXT, '
          'FOREIGN KEY(collectivityId) REFERENCES ${DbTableNames.collectivity}(collectivityId) ON DELETE CASCADE)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS ${DbTableNames.persons} ('
          'id INTEGER PRIMARY KEY, '
          'personId TEXT UNIQUE, '
          'name TEXT, '
          'localName TEXT, '
          'username TEXT UNIQUE, '
          'description TEXT, '
          'imageId TEXT, '
          'source TEXT DEFAULT \'SERVER\', '
          'isRegistered INTEGER DEFAULT 0,'
          'status TEXT DEFAULT \'CREATED\')');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS ${DbTableNames.messages} ('
          'id INTEGER PRIMARY KEY, '
          'messageId TEXT UNIQUE, '
          'message TEXT NOT NULL, '
          'userId TEXT NOT NULL, '
          'collectivityId TEXT, '
          'dyadReceiverId TEXT, '
          'sendTime DATE, '
          'status TEXT DEFAULT \'CREATED\', '
          'FOREIGN KEY(collectivityId) REFERENCES ${DbTableNames.collectivity}(collectivityId) ON DELETE CASCADE)');
    });
    return _database!;
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
