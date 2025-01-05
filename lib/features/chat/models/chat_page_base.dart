import 'package:chat_app/constants/enums/chat_page_base_model_source.dart';

import '../../../data/group/group.dart';
import '../../../data/person/person.dart';

class ChatPageBaseModel {
  final int? id;
  late int? localGroupId;
  final String? name;
  final String? ownerId;
  final int isDirectChat;
  final String? imageId;
  final ChatPageBaseModelSource source;
  final String? personId;

  ChatPageBaseModel(
      {this.id,
      this.localGroupId,
      this.name,
      this.ownerId,
      required this.isDirectChat,
      this.imageId,
      required this.source,
      this.personId});

  factory ChatPageBaseModel.fromPersonModel(PersonModel personModel) {
    return ChatPageBaseModel(
        name: personModel.localName,
        isDirectChat: 1,
        imageId: personModel.imageId,
        source: ChatPageBaseModelSource.CONTACT,
        personId: personModel.personId);
  }

  factory ChatPageBaseModel.fromPersonModelAndGroupModel(
      PersonModel personModel, GroupModel groupModel) {
    return ChatPageBaseModel(
        localGroupId: groupModel.id,
        name: personModel.localName,
        isDirectChat: 1,
        imageId: personModel.imageId,
        id: groupModel.id,
        source: ChatPageBaseModelSource.DIRECT_GROUP);
  }

  factory ChatPageBaseModel.fromGroupModel(GroupModel groupModel) {
    return ChatPageBaseModel(
        localGroupId: groupModel.id,
        name: groupModel.name,
        ownerId: groupModel.ownerId,
        isDirectChat: 0,
        imageId: groupModel.imageId,
        id: groupModel.id,
        source: ChatPageBaseModelSource.GROUP);
  }

  void setGroupId(int localGroupId) {
    this.localGroupId = localGroupId;
  }
}
