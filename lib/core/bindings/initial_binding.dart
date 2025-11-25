import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/router/app_router.dart';
import 'package:chat_app/core/services/sync/collectivity.dart';
import 'package:chat_app/core/services/sync/contact.dart';
import 'package:chat_app/core/services/sync/message.dart';
import 'package:chat_app/core/services/websocket/websocket_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void initInitialBindings() {
  if (!getIt.isRegistered<AppRouter>()) {
    getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  }

  if (!getIt.isRegistered<WebSocketClient>()) {
    getIt.registerLazySingleton<WebSocketClient>(() {
      final container = getIt<ProviderContainer>();
      return WebSocketClient(container);
    });
  }
  if (!getIt.isRegistered<ContactSyncService>()) {
    getIt.registerLazySingleton<ContactSyncService>(() => ContactSyncService());
  }
  if (!getIt.isRegistered<MessageSyncService>()) {
    getIt.registerLazySingleton<MessageSyncService>(() => MessageSyncService());
  }
  if (!getIt.isRegistered<CollectivitySyncService>()) {
    getIt.registerLazySingleton<CollectivitySyncService>(() => CollectivitySyncService());
  }

  if (!getIt.isRegistered<AppRouter>()) {
    getIt.registerSingleton<AppRouter>(AppRouter());
  }
}
