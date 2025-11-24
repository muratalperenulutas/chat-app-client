import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@singleton
class GeneralChangeNotifier {
  final ValueNotifier<int> isContactsChanged = ValueNotifier(0);
  final ValueNotifier<int> isMessagesChanged = ValueNotifier(0);
  final ValueNotifier<int> isCollectivitiesChanged = ValueNotifier(0);
  final ValueNotifier<int> isGroupParticipantsChanged = ValueNotifier(0);

  void contactsChanged(){
    debugPrint("contacts changed");
    isContactsChanged.value++;
  }
  void messagesChanged(){
    debugPrint("messages changed");
    isMessagesChanged.value++;
  }
  void collectivitiesChanged(){
    debugPrint("collectivities changed");
    isCollectivitiesChanged.value++;
  }
  void groupParticipantsChanged(){
    debugPrint("group participants changed");
    isGroupParticipantsChanged.value++;
  }
}