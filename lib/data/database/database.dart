import 'package:drift/drift.dart';
import 'package:chat_app/data/connection/connection.dart';
import 'package:chat_app/data/database/tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Collectivities, Participants, Persons, Messages])
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
      beforeOpen: (details) async {
        if (!details.wasCreated) {
          await customStatement('PRAGMA foreign_keys = ON');
        }
      },
    );
  }
}
