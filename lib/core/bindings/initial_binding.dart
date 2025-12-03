import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/router/app_router.dart';
import 'package:chat_app/core/services/sync/collectivity.dart';
import 'package:chat_app/core/services/sync/contact.dart';
import 'package:chat_app/core/services/sync/message.dart';
import 'package:chat_app/core/services/sync/sync.dart';
import 'package:chat_app/core/services/websocket/websocket_client.dart';
import 'package:chat_app/data/collectivity/collectivity_service.dart';
import 'package:chat_app/data/message/message_service.dart';
import 'package:chat_app/data/participant/participant_service.dart';
import 'package:chat_app/data/person/person_service.dart';
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

  if (!getIt.isRegistered<PersonService>()) {
    getIt.registerLazySingleton<PersonService>(() => PersonService());
  }

  if (!getIt.isRegistered<CollectivityService>()) {
    getIt.registerLazySingleton<CollectivityService>(() {
      final container = getIt<ProviderContainer>();
      return CollectivityService(container);
    });
  }

  if (!getIt.isRegistered<MessageService>()) {
    getIt.registerLazySingleton<MessageService>(() {
      final container = getIt<ProviderContainer>();
      return MessageService(container);
    });
  }

  if (!getIt.isRegistered<ParticipantService>()) {
    getIt.registerLazySingleton<ParticipantService>(() => ParticipantService());
  }

  if (!getIt.isRegistered<SyncService>()) {
    getIt.registerLazySingleton<SyncService>(() => SyncService());
  }

  if (!getIt.isRegistered<ContactSyncService>()) {
    getIt.registerSingleton<ContactSyncService>(ContactSyncService());
  }
  if (!getIt.isRegistered<MessageSyncService>()) {
    getIt.registerSingleton<MessageSyncService>(MessageSyncService());
  }
  if (!getIt.isRegistered<CollectivitySyncService>()) {
    getIt.registerSingleton<CollectivitySyncService>(CollectivitySyncService());
  }

  if (!getIt.isRegistered<AppRouter>()) {
    getIt.registerSingleton<AppRouter>(AppRouter());
  }
}
