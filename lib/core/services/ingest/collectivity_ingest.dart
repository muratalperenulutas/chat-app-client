import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/general_change_notifier.dart';
import 'package:chat_app/core/services/websocket/models/collectivity_id.dart';
import 'package:chat_app/core/services/websocket/websocket_client.dart';
import 'package:chat_app/data/collectivity/collectivity_abstract.dart';
import 'package:chat_app/data/collectivity/collectivity_repository.dart';
import 'package:chat_app/data/collectivity/collectivity_service.dart';
import 'package:chat_app/data/collectivity/dyad.dart';

import '../../../constants/enums/ws_message_type.dart';
import '../websocket/models/create_dyad.dart';
import '../websocket/models/create_group.dart';
import '../websocket/models/websocket_message.dart';

class CollectivityIngest {
  final GeneralChangeNotifier generalChangeNotifier = getIt<GeneralChangeNotifier>();
  final CollectivityService collectivityService = getIt<CollectivityService>();
  final WebSocketClient webSocketClient = getIt<WebSocketClient>();
  final CollectivityRepository collectivityRepository = getIt<CollectivityRepository>();

  CollectivityIngest() {
    // TODO: Add reactivity(Auto sync when connectivity is back or on data changes)
  }

  void syncCollectivities() async {
    if (webSocketClient.isWsConnected) {
      List<Collectivity> unsyncedCollectivities = await collectivityRepository.getUnsyncedCollectivities();
      for (Collectivity collectivity in unsyncedCollectivities) {
        if (collectivity.collectivityId != null || collectivity.collectivityId == "") {
          findCollectivity(collectivity.collectivityId!);
        } else {
          if (collectivity is Dyad) {
            createDyad(collectivity.id ?? 0, collectivity.userId);
          }
        }
      }
    }
  }

  void createGroup(String name, List<String> members) {
    WebsocketMessage message = WebsocketMessage(WsMessageType.CREATE_GROUP,
        "1", CreateGroup(name, members));
    webSocketClient.sendWebsocketMessage(message);
  }

  void createDyad(int id, String userId) {
    WebsocketMessage message = WebsocketMessage(WsMessageType.CREATE_DYAD,
        id.toString(), CreateDyad(userId));
    webSocketClient.sendWebsocketMessage(message);
  }

  void findCollectivity(String collectivityId) {
    WebsocketMessage message = WebsocketMessage(WsMessageType.GET_COLLECTIVITY,
        null, CollectivityId(collectivityId));
    webSocketClient.sendWebsocketMessage(message);
  }
}