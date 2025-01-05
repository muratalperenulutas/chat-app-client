import 'package:chat_app/data/person/person.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:chat_app/data/person/person_service.dart';
import 'package:chat_app/core/general_change_notifier.dart';
import 'package:get/get.dart';

class PersonController extends GetxController{
  RxList<PersonModel> contacts=<PersonModel>[].obs;
  RxList<PersonModel> contactsOnChatApp=<PersonModel>[].obs;
  RxList<PersonModel> contactsNotOnChatApp=<PersonModel>[].obs;

  PersonRepository personRepository=Get.find<PersonRepository>();
  PersonService personService=Get.find<PersonService>();
  GeneralChangeNotifier generalChangeNotifier=Get.find<GeneralChangeNotifier>();

  @override
  void onInit() {
    super.onInit();
    _loadData();
    ever(generalChangeNotifier.isContactsChanged, (_)async{
      _loadData();
    });
  }
  void _loadData()async{
    contacts.value=await personRepository.getContacts();
    contactsOnChatApp.value=await personRepository.getContactsOnChatApp();
    contactsNotOnChatApp.value=await personRepository.getContactsNotOnChatApp();
  }

  void createContact(String name,String username){
    personService.createContact(name, username);
  }

}