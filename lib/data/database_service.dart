import 'dart:async';
import 'package:chat_app/data/database/database.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:injectable/injectable.dart';

@singleton
class DatabaseService {
  AppDatabase? _database;
  String? _currentUserId;

  Future<void> init({String? userId}) async {
    try {
      await closeDatabase();
      _currentUserId = userId;
      if (_currentUserId == null) return;
      _initializeDatabase();
    } catch (e, stackTrace) {
      debugPrint('Database initialization error: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }

  AppDatabase getDatabase() {
    if (_database != null) return _database!;

    try {
      return _initializeDatabase();
    } catch (e) {
      debugPrint('Failed to get database: $e');
      throw Exception('Database unavailable');
    }
  }

  AppDatabase _initializeDatabase() {
    if (_database == null) {
      debugPrint('Initializing Drift database for user: $_currentUserId');
      final dbName =
          _currentUserId != null ? 'ChatApp_$_currentUserId' : 'ChatApp';
      _database = AppDatabase(dbName: dbName);
    }
    return _database!;
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
      await Future.delayed(const Duration(milliseconds: 10));
    }
    _currentUserId = null;
  }
}
