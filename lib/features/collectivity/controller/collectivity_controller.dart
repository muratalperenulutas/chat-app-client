import 'package:chat_app/core/general_change_notifier.dart';
import 'package:chat_app/data/collectivity/collectivity_abstract.dart';
import 'package:chat_app/data/collectivity/collectivity_repository.dart';
import 'package:chat_app/data/collectivity/collectivity_service.dart';
import 'package:chat_app/features/chat/models/chat_base.dart';
import 'package:get/get.dart';

class CollectivityController extends GetxController{
  RxList<Collectivity> collectivities=<Collectivity>[].obs;
  RxList<ChatBase> chatBaseModels=<ChatBase>[].obs;

  CollectivityService collectivityService=Get.find<CollectivityService>();
  CollectivityRepository collectivityRepository=Get.find<CollectivityRepository>();
  GeneralChangeNotifier generalChangeNotifier=Get.find<GeneralChangeNotifier>();

  @override
  void onInit() {
    super.onInit();
    _loadData();
    everAll([generalChangeNotifier.isCollectivitiesChanged,generalChangeNotifier.isContactsChanged], (_){
      _loadData();
    });
  }

  void _loadData()async{
    collectivities.value=await collectivityRepository.getCollectivities();
    chatBaseModels.value=await ChatBase.fromCollectivities(collectivities);
  }
}