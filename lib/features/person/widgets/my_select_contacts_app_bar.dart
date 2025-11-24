import 'package:auto_route/auto_route.dart';
import 'package:chat_app/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/person_controller.dart';

class MySelectContactsAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const MySelectContactsAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personState = ref.watch(personControllerProvider);

    if (personState.selectedContacts.isNotEmpty) {
      return AppBar(
        backgroundColor: Colors.purple,
        title: Text(personState.selectedContacts.length.toString()),
        actions: [
          MaterialButton(
            child: Text("New Group"),
            onPressed: () {
              AutoRouter.of(context).push(CreateGroupRoute());
            },
          ),
        ],
      );
    } else {
      return AppBar(
        backgroundColor: Colors.amber,
        title: Text("Select Contact"),
      );
    }
  }
}
