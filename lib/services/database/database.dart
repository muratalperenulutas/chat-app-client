import 'dart:async';
import 'package:chat_app/models/group.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/person.dart';
import 'package:chat_app/models/personOriginType.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static const int _version = 1;
  static const String _dbName = "ChatApp.db"; //ChatApp?UserId?324.db
  static int? _userId;
  static Database? _database; 

  static const String messagesTableName = "messages";
  static const String groupParticipantsTableName = "groupParticipants";
  static const String groupsTableName = "groups";
  static const String personsTableName = "persons";

  static Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getInt('user-id');
  }

  static Future<Database> _getDatabase() async {
    if (_database != null) return _database!;

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dbName);
    _database = await openDatabase(path, version: _version,
        onCreate: (Database db, int version) async {
          await db.execute('PRAGMA foreign_keys = ON');
          await db.execute(
              'CREATE TABLE IF NOT EXISTS $groupsTableName ('
                  'id INTEGER PRIMARY KEY, '
                  'groupId TEXT,'
                  'name TEXT NOT NULL, '
                  'ownerId TEXT, '
                  'description TEXT, '
                  'isDirectChat INTEGER NOT NULL, '
                  'imageId TEXT, '
                  'isSynced INTEGER DEFAULT 0)');
          await db.execute(
              'CREATE TABLE IF NOT EXISTS $groupParticipantsTableName ('
                  'id INTEGER PRIMARY KEY, '
                  'groupId INTEGER NOT NULL, '
                  'participantId INTEGER NOT NULL, '
                  'isSynced INTEGER DEFAULT 0, '
                  'FOREIGN KEY(groupId) REFERENCES $groupsTableName(groupId) ON DELETE CASCADE, '
                  'FOREIGN KEY(participantId) REFERENCES $personsTableName(personId) ON DELETE CASCADE)');
          await db.execute(
              'CREATE TABLE IF NOT EXISTS $personsTableName ('
                  'id INTEGER PRIMARY KEY, '
                  'personId TEXT UNIQUE, '
                  'name TEXT NOT NULL, '
                  'username TEXT, '
                  'identifier TEXT UNIQUE, '
                  'description TEXT, '
                  'imageId TEXT, '
                  'type TEXT NOT NULL, '
                  'isRegistered INTEGER NOT NULL DEFAULT 0, '
                  'isSynced INTEGER DEFAULT 0)');
          await db.execute(
              'CREATE TABLE IF NOT EXISTS $messagesTableName ('
                  'id INTEGER PRIMARY KEY, '
                  'messageId INTEGER, '
                  'message TEXT NOT NULL, '
                  'senderId INTEGER NOT NULL, '
                  'groupId INTEGER NOT NULL, '
                  'isSend INTEGER DEFAULT 0, '
                  'isSynced INTEGER DEFAULT 0, '
                  'FOREIGN KEY(groupId) REFERENCES $groupsTableName(groupId) ON DELETE CASCADE, '
                  'FOREIGN KEY(senderId) REFERENCES $personsTableName(personId) ON DELETE CASCADE)');
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

  static Future<void> insertGroup(GroupModel group) async {
    final db = await _getDatabase();
    await db.insert(groupsTableName, group.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> insertContacts(PersonModel person) async {
    final db = await _getDatabase();
    final existingContacts = await db.query(
      personsTableName,
      where: 'identifier = ?',
      whereArgs: [person.identifier],
    );
    if (existingContacts.isNotEmpty) {
      throw Exception("Contact with the same identifier already exists!");
    }
    await db.insert(personsTableName, person.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<MessageModel>> getMessagesFromGroupById(
      String groupId) async {
    final db = await _getDatabase();
    final list = await db.rawQuery(
        'SELECT * FROM $messagesTableName WHERE id = ?', [groupId]);
    return list.map((map) => MessageModel.fromDb(map)).toList();
  }


  static Future<List<GroupModel>> getGroups() async {
    final db = await _getDatabase();
    final list = await db.rawQuery('SELECT * FROM $groupsTableName');
    return list.map((map) => GroupModel.fromDb(map)).toList();
  }

  static Future<GroupModel?> getDirectGroupByUserId(String participantId) async {
    final db = await _getDatabase();
    final list = await db.rawQuery('''
    SELECT * FROM $groupsTableName g
    JOIN $groupParticipantsTableName gp ON g.groupId = gp.groupId
    WHERE g.isDirectChat = 1 AND gp.participantId = ?
  ''', [participantId]);

    return list.isNotEmpty? GroupModel.fromDb(list.first):null;
  }

  static Future<PersonModel?> getPersonFromDirectGroup(String groupId) async {
    final db = await _getDatabase();
    final list = await db.rawQuery('''
    SELECT p.* FROM $personsTableName p
    JOIN $groupParticipantsTableName gp ON p.personId = gp.participantId
    JOIN $groupsTableName g ON gp.groupId = g.groupId
    WHERE g.isDirectChat = 1 AND g.groupId = ?
  ''', [groupId]);

    if (list.isNotEmpty && list.length == 2) {
      final otherParticipant = list.firstWhere((map) => map['personId'] != _userId);
      return PersonModel.fromDb(otherParticipant);
    }
    return null;
  }


  static Future<GroupModel> getGroupByGroupId(String groupId) async {
    final db = await _getDatabase();
    final list = await db.rawQuery('SELECT * FROM $groupsTableName WHERE groupId = ?',[groupId]);
    return list.map((map) => GroupModel.fromDb(map)).toList().first;
  }

  static Future<List<PersonModel>> getContacts() async {
      final db = await _getDatabase();
      final list = await db.rawQuery(
          'SELECT * FROM $personsTableName WHERE type = ?',[PersonOriginType.contact.toString()]);
      return list.map((map) => PersonModel.fromDb(map)).toList();
  }

  static Future<List<PersonModel>> getContactsOnChatApp() async {
    final db = await _getDatabase();
    final list = await db.rawQuery(
        'SELECT * FROM $personsTableName WHERE type = ? AND isRegistered = ?',[PersonOriginType.contact.toString(),1]);
    return list.map((map) => PersonModel.fromDb(map)).toList();
  }


  static Future<List<PersonModel>> getContactsNotOnChatApp() async {
    final db = await _getDatabase();
    final list = await db.rawQuery('SELECT * FROM $personsTableName WHERE type = ? AND isRegistered = ?',[PersonOriginType.contact.toString(),0]);
    return list.map((map) => PersonModel.fromDb(map)).toList();
  }

  static Future<List<PersonModel>> sendMessageToGroup(int groupId,String message,int userId) async {
    final db = await _getDatabase();
    final list = await db.rawQuery('SELECT * FROM $personsTableName WHERE type = ? AND isRegistered = ?',[PersonOriginType.contact.toString(),0]);
    return list.map((map) => PersonModel.fromDb(map)).toList();
  }

  static Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null; 
    }
  }
}
