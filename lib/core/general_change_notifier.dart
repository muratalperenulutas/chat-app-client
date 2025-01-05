import 'package:get/get.dart';

class GeneralChangeNotifier extends GetxService{
  final RxInt isContactsChanged=0.obs;
  final RxInt isMessagesChanged=0.obs;
  final RxInt isGroupsChanged=0.obs;
  final RxInt isGroupParticipantsChanged=0.obs;

  void contactsChanged(){
    print("contacts changed");
    isContactsChanged.value++;
  }
  void messagesChanged(){
    print("messages changed");
    isMessagesChanged.value++;
  }
  void groupsChanged(){
    print("groups changed");
    isGroupsChanged.value++;
  }
  void groupParticipantsChanged(){
    print("group participants changed");
    isGroupParticipantsChanged.value++;
  }
}