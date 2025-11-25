import 'package:auto_route/auto_route.dart';
import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/services/sync/collectivity.dart';
import 'package:chat_app/features/person/controller/person_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class CreateGroupPage extends ConsumerStatefulWidget {
  const CreateGroupPage({super.key});

  @override
  ConsumerState<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends ConsumerState<CreateGroupPage> {
  CollectivitySyncService collectivitySyncService = getIt<CollectivitySyncService>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final personState = ref.watch(personControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("New Group"),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          IconButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  collectivitySyncService.createGroup(_nameController.text,
                      personState.selectedContacts.toList());
                  context.router.replacePath('/home');
                }
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
                hintText: "Name",
                labelStyle: TextStyle(color: Colors.black),
                border: UnderlineInputBorder()),
          )
        ],
      ),
    );
  }
}
