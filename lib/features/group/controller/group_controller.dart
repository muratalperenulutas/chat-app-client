import 'package:chat_app/core/general_change_notifier.dart';
import 'package:chat_app/data/group/group.dart';
import 'package:chat_app/data/group/group_repository.dart';
import 'package:chat_app/data/group/group_service.dart';
import 'package:get/get.dart';

class GroupController extends GetxController{
  RxList<GroupModel> groups=<GroupModel>[].obs;

  GroupService groupService=Get.find<GroupService>();
  GroupRepository groupRepository=Get.find<GroupRepository>();
  GeneralChangeNotifier generalChangeNotifier=Get.find<GeneralChangeNotifier>();

  @override
  void onInit() {
    super.onInit();
    _loadData();
    ever(generalChangeNotifier.isGroupsChanged, (_){
      _loadData();
    });
  }

  void _loadData()async{
    groups.value=await groupRepository.getGroups();
  }
}