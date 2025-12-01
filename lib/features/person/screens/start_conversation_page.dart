import 'package:auto_route/auto_route.dart';
import 'package:chat_app/features/person/controller/person_controller.dart';
import 'package:chat_app/features/person/widgets/my_select_contacts_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/build_start_conversation_body.dart';

@RoutePage()
class StartConversationPage extends ConsumerStatefulWidget {
  const StartConversationPage({super.key});

  @override
  ConsumerState<StartConversationPage> createState() => _StartConversationPageState();
}

class _StartConversationPageState extends ConsumerState<StartConversationPage> {
  late final PersonController _personController;

  @override
  void initState() {
    super.initState();
    _personController = ref.read(personControllerProvider.notifier);
  }

  @override
  void dispose() {
    Future.microtask(() => _personController.resetSelectedContacts());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MySelectContactsAppBar(),
      body: BuildStartConversationBody(screenHeight: screenHeight),
    );
  }
}
