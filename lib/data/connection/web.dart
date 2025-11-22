import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:flutter/foundation.dart';

/// Opens a web-based database connection using WASM
QueryExecutor openConnection() {
  return DatabaseConnection.delayed(Future(() async {
    final result = await WasmDatabase.open(
      databaseName: 'ChatApp',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.dart.js'),
    );

    debugPrint('Database opened: ${result.chosenImplementation}');
    
    if (result.missingFeatures.isNotEmpty) {
      debugPrint('Missing browser features: ${result.missingFeatures}');
    }

    return result.resolvedExecutor;
  }));
}
