import 'dart:async';
import 'package:chat_app/data/database/database.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:get/get.dart';

class DatabaseService extends GetxService {
  AppDatabase? _database;

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
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
      debugPrint('Initializing Drift database');
      _database = AppDatabase();
    }
    return _database!;
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
