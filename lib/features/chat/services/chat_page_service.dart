import 'package:chat_app/data/group/group_repository.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:chat_app/features/chat/models/chat_page_base.dart';
import 'package:get/get.dart';

import '../../../data/group/group.dart';
import '../../../data/person/person.dart';

class ChatPageService extends GetxService{
  GroupRepository groupRepository=Get.find<GroupRepository>();
  PersonRepository personRepository=Get.find<PersonRepository>();

  Future<ChatPageBaseModel?> createChatPageBaseModelFromGroupModelAndPersonModel(GroupModel? groupModel, PersonModel? personModel) async {
    if (personModel != null) {
      GroupModel? group =
      await groupRepository.getDirectGroupByUserId(personModel.personId!);

      if (group != null) {
        return ChatPageBaseModel.fromPersonModelAndGroupModel(
            personModel, group);
      } else {
        return ChatPageBaseModel.fromPersonModel(personModel);
      }
    } else if (groupModel?.isDirectGroup == 1) {
      print(groupModel?.id);
      PersonModel? person = await personRepository.getPersonFromDirectGroupByLocalId(
          groupModel!.id??0);

      if (person != null) {
        return ChatPageBaseModel.fromPersonModelAndGroupModel(
            person, groupModel);
      } else {
        printError(info: "Error: PersonModel not found for direct group.");
      }
    } else if (groupModel?.isDirectGroup == 0) {
      return ChatPageBaseModel.fromGroupModel(groupModel!);
    } else {
      print("Error: Invalid condition.");
    }
    return null;
  }
}