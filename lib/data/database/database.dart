import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:chat_app/data/connection/connection.dart';
import 'package:chat_app/data/database/tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Collectivities, Participants, Persons, Messages, Contacts])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        //await m.runMigrationSteps(from: from,to: to,steps:(currentVersion, database) {
        //  database.update()
        //},);
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
        
    
        debugPrint('========= Database Info =========');
        debugPrint('Schema version: ${details.versionNow}');
        debugPrint('Was created: ${details.wasCreated}');
        debugPrint('Had upgrade: ${details.hadUpgrade}');
        
        final tables = await customSelect(
          "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'",
        ).get();
        
        debugPrint('Tables in database:');
        for (final table in tables) {
          final tableName = table.read<String>('name');
          debugPrint('  - $tableName');
          
          final columns = await customSelect(
            "PRAGMA table_info('$tableName')",
          ).get();
          
          for (final col in columns) {
            debugPrint('      Column: ${col.read<String>('name')} (${col.read<String>('type')})');
          }
        }
        debugPrint('===============================');
      },
    );
  }
}
