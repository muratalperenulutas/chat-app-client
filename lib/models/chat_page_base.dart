import 'package:chat_app/models/chatPageBaseModelSourceEnum.dart';
import 'package:chat_app/models/group.dart';
import 'package:chat_app/models/person.dart';
import 'package:chat_app/services/database/database.dart';

class ChatPageBaseModel {
  final int? id;
  final int? groupId;
  final String? name;
  final String? ownerId;
  final int isDirectChat;
  final String? imageId;
  final Enum source;

  const ChatPageBaseModel(
      {this.id,
      this.groupId,
      this.name,
      this.ownerId,
      required this.isDirectChat,
      this.imageId,
      required this.source});

  factory ChatPageBaseModel.fromPersonModel(PersonModel personModel) {
    return ChatPageBaseModel(
        name: personModel.name,
        isDirectChat: 1,
        imageId: personModel.imageId,
        source: ChatPageBaseModelSource.contact);
  }

  factory ChatPageBaseModel.fromPersonModelAndGroupModel(
      PersonModel personModel, GroupModel groupModel) {
    return ChatPageBaseModel(
        groupId: groupModel.groupId,
        name: personModel.name,
        isDirectChat: 1,
        imageId: personModel.imageId,
        id: groupModel.id,
        source: ChatPageBaseModelSource.directGroup);
  }

  factory ChatPageBaseModel.fromGroupModel(GroupModel groupModel) {
    return ChatPageBaseModel(
        groupId: groupModel.groupId,
        name: groupModel.name,
        ownerId: groupModel.ownerId,
        isDirectChat: 0,
        imageId: groupModel.imageId,
        id: groupModel.id,
        source: ChatPageBaseModelSource.group);
  }

  static Future<ChatPageBaseModel?> createForChatPage(
      GroupModel? groupModel, PersonModel? personModel) async {
    if (personModel != null) {
      GroupModel? group =
          await DatabaseManager.getDirectGroupByUserId(personModel.personId!);

      if (group != null) {
        return ChatPageBaseModel.fromPersonModelAndGroupModel(
            personModel, group);
      } else {
        return ChatPageBaseModel.fromPersonModel(personModel);
      }
    } else if (groupModel?.isDirectChat == 1) {
      PersonModel? person = await DatabaseManager.getPersonFromDirectGroup(
          groupModel!.groupId.toString());

      if (person != null) {
        return ChatPageBaseModel.fromPersonModelAndGroupModel(
            person, groupModel);
      } else {
        print("Error: PersonModel not found for direct group.");
      }
    } else if (groupModel?.isDirectChat == 0) {
      return ChatPageBaseModel.fromGroupModel(groupModel!);
    } else {
      print("Error: Invalid condition.");
    }

    return null;
  }
}
