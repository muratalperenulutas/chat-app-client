import 'package:chat_app/data/group/group_repository.dart';
import 'package:chat_app/data/group_participant/group_participant_repository.dart';
import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../group_participant/group_participant.dart';
import 'group.dart';

class GroupService extends GetxService {
  final GroupRepository groupRepository=Get.find<GroupRepository>();
  final GroupParticipantRepository groupParticipantRepository=Get.find<GroupParticipantRepository>();
  final AuthController authController=Get.find<AuthController>();

  Future<int> createDirectGroup(String? name, String userId) async {
    GroupModel groupModel = GroupModel(isDirectGroup: 1, name: name,ownerId:authController.userId.value );
    int id = await groupRepository.insertGroup(groupModel);

    GroupParticipantModel groupParticipantModel = GroupParticipantModel(
        localGroupId:id, userId: userId, isSynced: 0);
    groupParticipantRepository
        .insertGroupParticipant(groupParticipantModel);
    GroupParticipantModel participant = GroupParticipantModel(
        localGroupId: id, userId: authController.userId.value, isSynced: 0);
    groupParticipantRepository
        .insertGroupParticipant(participant);
    return id;
  }

  Future<void> updateGroup(GroupModel groupModel, int reqId) async {
    await groupRepository.updateGroup(groupModel, reqId);
  }

  Future<void> saveGroup(GroupModel groupModel) async {
    await groupRepository.insertGroup(groupModel);
  }
}
