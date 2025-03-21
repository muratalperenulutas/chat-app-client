import 'package:chat_app/core/general_change_notifier.dart';
import 'package:chat_app/core/services/websocket/websocket_client.dart';
import 'package:chat_app/data/collectivity/collectivity_abstract.dart';
import 'package:chat_app/data/collectivity/collectivity_repository.dart';
import 'package:chat_app/data/collectivity/collectivity_service.dart';
import 'package:chat_app/data/collectivity/dyad.dart';
import 'package:get/get.dart';

import '../../../constants/enums/ws_message_type.dart';
import '../websocket/models/create_dyad.dart';
import '../websocket/models/create_group.dart';
import '../websocket/models/websocket_message.dart';

class GroupDataIngest extends GetxService{
    final GeneralChangeNotifier generalChangeNotifier=Get.find<GeneralChangeNotifier>();
    final CollectivityService collectivityService=Get.find<CollectivityService>();
    final WebSocketClient webSocketClient=Get.find<WebSocketClient>();
    final CollectivityRepository collectivityRepository=Get.find<CollectivityRepository>();

    GroupDataIngest(){
        ever(generalChangeNotifier.isCollectivitiesChanged, (count) async {
            List<Collectivity> unsyncedCollectivities=await collectivityRepository.getUnsyncedCollectivities();
            await collectivityRepository.printAll();
            print("unscnced "+unsyncedCollectivities.toString());
            for(Collectivity collectivity in unsyncedCollectivities){
                if(collectivity is DyadModel){
                    print("dyadId ${collectivity.id}");
                    createDyad(collectivity.id??0, collectivity.userId);
                }
            }
        });
    }
    void createGroup(String name,int id,List<String> members){
        WebsocketMessage message = WebsocketMessage(WsMessageType.CREATE_GROUP,
            id.toString(), CreateGroup(name, true, members));
        webSocketClient.sendWebsocketMessage(message);
    }

    void createDyad(int id,String userId){
        WebsocketMessage message = WebsocketMessage(WsMessageType.CREATE_DYAD,
            id.toString(), CreateDyad(userId));
        webSocketClient.sendWebsocketMessage(message);
    }
}