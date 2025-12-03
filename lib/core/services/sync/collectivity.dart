import 'dart:async';

import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/services/sync/sync.dart';
import 'package:chat_app/core/services/websocket/models/collectivity_id.dart';
import 'package:chat_app/data/collectivity/collectivity_abstract.dart';
import 'package:chat_app/data/collectivity/collectivity_repository.dart';
import 'package:chat_app/data/collectivity/collectivity_service.dart';
import 'package:chat_app/data/collectivity/dyad.dart';

import '../../../constants/enums/ws_message_type.dart';
import '../websocket/models/create_dyad.dart';
import '../websocket/models/create_group.dart';
import '../websocket/models/websocket_message.dart';

class CollectivitySyncService {
  final CollectivityService collectivityService = getIt<CollectivityService>();
  final CollectivityRepository collectivityRepository = getIt<CollectivityRepository>();
  final SyncService syncService = getIt<SyncService>();
  
  StreamSubscription<List<Collectivity>>? _unsyncedCollectivitiesSubscription;

  CollectivitySyncService();

  void init() {
    dispose();
    _setupAutoSync();
  }

  void _setupAutoSync() {
    _unsyncedCollectivitiesSubscription = collectivityRepository.watchUnsyncedCollectivities().listen((collectivities) {
      if (collectivities.isNotEmpty) {
        _syncCollectivities(collectivities);
      }
    });
    
    collectivityRepository.checkPendingCollectivitiesTimeout();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      collectivityRepository.checkPendingCollectivitiesTimeout();
    });
  }

  void _syncCollectivities(List<Collectivity> collectivities) {
    for (Collectivity collectivity in collectivities) {
      if (collectivity.collectivityId != null && collectivity.collectivityId != "") {
        _findCollectivity(collectivity.collectivityId!);
      } else {
        if (collectivity is Dyad) {
          _createDyad(collectivity.id ?? 0, collectivity.userId);
        }
      }
    }
  }

  void createGroup(String name, List<String> members) {
    WebsocketMessage message = WebsocketMessage(
      WsMessageType.CREATE_GROUP,
      "1", 
      CreateGroup(name, members)
    );
    syncService.sendMessage(message);
  }

  void _createDyad(int id, String userId) {
    WebsocketMessage message = WebsocketMessage(
      WsMessageType.CREATE_DYAD,
      id.toString(), 
      CreateDyad(userId)
    );
    syncService.sendMessage(message);
  }

  void _findCollectivity(String collectivityId) {
    WebsocketMessage message = WebsocketMessage(
      WsMessageType.GET_COLLECTIVITY,
      null, 
      CollectivityId(collectivityId)
    );
    syncService.sendMessage(message);
  }
  
  void dispose() {
    _unsyncedCollectivitiesSubscription?.cancel();
  }
}