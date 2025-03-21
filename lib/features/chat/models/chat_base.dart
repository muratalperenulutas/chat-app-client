import 'package:chat_app/data/collectivity/collectivity_abstract.dart';
import 'package:chat_app/data/collectivity/dyad.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:get/get.dart';

import '../../../data/collectivity/group.dart';
import '../../../data/person/person.dart';

class ChatBaseModel {
  late int? collectivityId;
  final String? name;
  final String? creatorId;
  final String? imageId;
  final String? personId;

  ChatBaseModel(
      {this.collectivityId,
      this.name,
      this.creatorId,
      this.imageId,
      this.personId,});

  factory ChatBaseModel.fromPersonModel(PersonModel personModel) {
    return ChatBaseModel(
        name: personModel.localName,
        imageId: personModel.imageId,
        personId: personModel.personId,);
  }
  factory ChatBaseModel.fromPersonAndDyadModel(PersonModel personModel,DyadModel dyad) {
    return ChatBaseModel(
      collectivityId: dyad.collectivityId,
        name: personModel.localName,
        imageId: personModel.imageId,
        personId: personModel.personId,);
  }

  factory ChatBaseModel.fromGroupModel(GroupModel groupModel) {
    return ChatBaseModel(
        name: groupModel.name,
        creatorId: groupModel.creatorId,
        imageId: groupModel.imageId,
        collectivityId: groupModel.collectivityId,);
  }

   static Future<List<ChatBaseModel>> fromCollectivities(List<Collectivity> collectivities) async {
    List<ChatBaseModel> chatBaseModels=<ChatBaseModel>[];
    for(Collectivity collectivity in collectivities) {
      if (collectivity is GroupModel) {
        chatBaseModels.add(ChatBaseModel.fromGroupModel(collectivity));
      } else if (collectivity is DyadModel) {
          PersonRepository personRepository=Get.find<PersonRepository>();
          PersonModel? personModel = await personRepository
              .findPersonByPersonId(collectivity.userId);
          if(personModel!=null) {
            chatBaseModels.add(
                ChatBaseModel.fromPersonAndDyadModel(
                    personModel, collectivity));
          }
          print(personModel==null?"person model null":"");
      } else {
        print("Error: Invalid condition." + collectivity.toString());
        throw Error();
      }
    }
    return chatBaseModels;
  }
}
