import 'dart:async';
import 'package:chat_app/models/group.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/person.dart';
import 'package:chat_app/models/sourceEnum.dart';
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
      await db.execute('CREATE TABLE IF NOT EXISTS $groupsTableName ('
          'id INTEGER PRIMARY KEY, '
          'groupId INTEGER UNIQUE,'
          'name TEXT, '
          'ownerId TEXT, '
          // 'description TEXT, '
          'isDirectGroup INTEGER NOT NULL, '
          'imageId TEXT, '
          'isSynced INTEGER DEFAULT 0)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS $groupParticipantsTableName ('
          'id INTEGER PRIMARY KEY, '
          'groupId INTEGER NOT NULL, '
          'participantId TEXT NOT NULL, '
          'isSynced INTEGER DEFAULT 0, '
          'FOREIGN KEY(groupId) REFERENCES $groupsTableName(groupId) ON DELETE CASCADE, '
          'FOREIGN KEY(participantId) REFERENCES $personsTableName(personId) ON DELETE CASCADE)');
      await db.execute('CREATE TABLE IF NOT EXISTS $personsTableName ('
          'id INTEGER PRIMARY KEY, '
          'personId TEXT UNIQUE, '
          'name TEXT, '
          'localName TEXT, '
          'username TEXT UNIQUE, '
          'description TEXT, '
          'imageId TEXT, '
          'source TEXT NOT NULL, '
          'isRegistered INTEGER DEFAULT 0, '
          'isSynced INTEGER DEFAULT 0)');
      await db.execute('CREATE TABLE IF NOT EXISTS $messagesTableName ('
          'id INTEGER PRIMARY KEY, '
          'messageId INTEGER UNIQUE, '
          'message TEXT NOT NULL, '
          'userId TEXT NOT NULL, '
          'groupId INTEGER NOT NULL, '
          'syncTime DATE, '
          'isRead INTEGER DEFAULT 0, '
          'isSynced INTEGER DEFAULT 0, '
          'FOREIGN KEY(groupId) REFERENCES $groupsTableName(groupId) ON DELETE CASCADE, '
          'FOREIGN KEY(userId) REFERENCES $personsTableName(personId) ON DELETE CASCADE)');
    });
    return _database!;
  }

  static Future<int> insertMessage(MessageModel messageModel) async {
    final db = await _getDatabase();
    return db.insert(messagesTableName, messageModel.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace); //returns id of row
  }

  static Future<int> updateMessage(
      int messageId, MessageModel messageModel) async {
    final db = await _getDatabase();
    return db.update(
      messagesTableName,
      messageModel.toDb(),
      where: 'id = ?',
      whereArgs: [messageId],
    );
  }

  static Future<void> insertGroupParticipant(Map<String, dynamic> data) async {
    final db = await _getDatabase();
    await db.insert(groupParticipantsTableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> insertGroup(GroupModel group) async {
    final db = await _getDatabase();
    return db.insert(groupsTableName, group.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateGroup(GroupModel group, int id) async {
    group.setId(id);
    final db = await _getDatabase();
    return db.update(
      groupsTableName,
      group.toDb(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> updatePerson(
      PersonModel existingPerson, PersonModel person) async {
    PersonModel personModel = PersonModel(
        name: person.name,
        source: existingPerson.source,
        personId: person.personId,
        isSynced: 1,
        isRegistered: 1,
        description: person.description,
        imageId: person.imageId,
        localName: existingPerson.localName,
        username: existingPerson.username,
        id: existingPerson.id);
    final db = await _getDatabase();
    return db.update(
      personsTableName,
      personModel.toDb(),
      where: 'id = ?',
      whereArgs: [existingPerson.id],
    );
  }

  static Future<void> insertPerson(PersonModel person) async {
    try {
      final db = await _getDatabase();
      await db.insert(
        personsTableName,
        person.toDb(),
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
    } catch (e) {
      print("Error inserting person: $e");
      rethrow;
    }
  }

  static Future<void> fetchPersonFromServer(PersonModel person) async {
    final db = await _getDatabase();

    try {
      final existingPerson = await findPersonByUsername(person.username ?? '');

      if (existingPerson != null) {
        await updatePerson(existingPerson, person);
      } else {
        await db.insert(
          personsTableName,
          person.toDb(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    } catch (e) {
      print("Error inserting person: $e");
    }
  }

  static Future<PersonModel?> findPersonByUsername(String username) async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      personsTableName,
      where: 'username = ?',
      whereArgs: [username],
    );

    if (result.isNotEmpty) {
      return PersonModel.fromDb(result.first);
    } else {
      return null;
    }
  }

  static Future<List<MessageModel>> getMessagesFromGroup(String groupId) async {
    final db = await _getDatabase();
    final list = await db.rawQuery(
        'SELECT * FROM $messagesTableName WHERE groupId = ?', [groupId]);
    return list.map((map) => MessageModel.fromDb(map)).toList();
  }

  static Future<List<GroupModel>> getGroups() async {
    final db = await _getDatabase();
    final list = await db.rawQuery('SELECT * FROM $groupsTableName');
    return list.map((map) => GroupModel.fromDb(map)).toList();
  }

  static Future<GroupModel?> getDirectGroupByUserId(
      String participantId) async {
    final db = await _getDatabase();
    final list = await db.rawQuery('''
    SELECT * FROM $groupsTableName g
    JOIN $groupParticipantsTableName gp ON g.groupId = gp.groupId
    WHERE g.isDirectGroup = 1 AND gp.participantId = ?
  ''', [participantId]);

    return list.isNotEmpty ? GroupModel.fromDb(list.first) : null;
  }

  static Future<PersonModel?> getPersonFromDirectGroup(String groupId) async {
    final db = await _getDatabase();
    final list = await db.rawQuery('''
    SELECT p.* FROM $personsTableName p
    JOIN $groupParticipantsTableName gp ON p.personId = gp.participantId
    JOIN $groupsTableName g ON gp.groupId = g.groupId
    WHERE g.isDirectGroup = 1 AND g.groupId = ?
  ''', [groupId]);

    if (list.isNotEmpty && list.length == 2) {
      final otherParticipant =
          list.firstWhere((map) => map['personId'] != _userId);
      return PersonModel.fromDb(otherParticipant);
    }
    return null;
  }

  static Future<GroupModel> getGroupByGroupId(String groupId) async {
    final db = await _getDatabase();
    final list = await db.rawQuery(
        'SELECT * FROM $groupsTableName WHERE groupId = ?', [groupId]);
    return list.map((map) => GroupModel.fromDb(map)).toList().first;
  }

  static Future<List<PersonModel>> getContacts() async {
    final db = await _getDatabase();
    final list = await db.rawQuery(
        'SELECT * FROM $personsTableName WHERE source = ?',
        [SourceEnum.LOCAL.toString()]);
    return list.map((map) => PersonModel.fromDb(map)).toList();
  }

  static Future<List<PersonModel>> getContactsOnChatApp() async {
    final db = await _getDatabase();
    final list = await db.rawQuery(
        'SELECT * FROM $personsTableName WHERE source = ? AND isRegistered = ?',
        [SourceEnum.LOCAL.toString(), 1]);
    return list.map((map) => PersonModel.fromDb(map)).toList();
  }

  static Future<List<PersonModel>> getContactsNotOnChatApp() async {
    final db = await _getDatabase();
    final list = await db.rawQuery(
        'SELECT * FROM $personsTableName WHERE source = ? AND isRegistered = ?',
        [SourceEnum.LOCAL.toString(), 0]);
    return list.map((map) => PersonModel.fromDb(map)).toList();
  }

  static Future<List<PersonModel>> sendMessageToGroup(
      int groupId, String message, String userId) async {
    final db = await _getDatabase();
    final list = await db.rawQuery(
        'SELECT * FROM $messagesTableName WHERE source = ? AND isRegistered = ?',
        [SourceEnum.LOCAL.toString(), 0]);
    return list.map((map) => PersonModel.fromDb(map)).toList();
  }

  static Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
