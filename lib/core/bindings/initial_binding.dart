import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/general_change_notifier.dart';
import 'package:chat_app/core/router/app_router.dart';
import 'package:chat_app/core/services/ingest/collectivity_ingest.dart';
import 'package:chat_app/core/services/ingest/contact_ingest.dart';
import 'package:chat_app/core/services/ingest/message_ingest.dart';
import 'package:chat_app/core/services/websocket/websocket_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void initInitialBindings() {
  if (!getIt.isRegistered<AppRouter>()) {
    getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  }

  if (!getIt.isRegistered<GeneralChangeNotifier>()) {
    getIt.registerLazySingleton<GeneralChangeNotifier>(() => GeneralChangeNotifier());
  }

  if (!getIt.isRegistered<WebSocketClient>()) {
    getIt.registerLazySingleton<WebSocketClient>(() {
      final container = getIt<ProviderContainer>();
      return WebSocketClient(container);
    });
  }
  if (!getIt.isRegistered<ContactDataIngest>()) {
    getIt.registerLazySingleton<ContactDataIngest>(() => ContactDataIngest());
  }
  if (!getIt.isRegistered<MessageDataIngest>()) {
    getIt.registerLazySingleton<MessageDataIngest>(() => MessageDataIngest());
  }
  if (!getIt.isRegistered<CollectivityIngest>()) {
    getIt.registerLazySingleton<CollectivityIngest>(() => CollectivityIngest());
  }

  if (!getIt.isRegistered<AppRouter>()) {
    getIt.registerSingleton<AppRouter>(AppRouter());
  }
}
