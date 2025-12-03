import 'package:auto_route/auto_route.dart';
import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/router/app_router.dart';
import 'package:chat_app/core/services/notification/notification_service.dart';
import 'package:chat_app/core/services/sync/collectivity.dart';
import 'package:chat_app/core/services/sync/contact.dart';
import 'package:chat_app/core/services/sync/message.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    _initServices();
  }

  Future<void> _initServices() async {
    getIt<ContactSyncService>().init();
    getIt<MessageSyncService>().init();
    getIt<CollectivitySyncService>().init();

    try {
      await NotificationService.instance.initialize();
      debugPrint('Notification service initialized successfully');
    } catch (e) {
      debugPrint('Notification service initialization error: $e');
    }

    await Future.delayed(const Duration(microseconds: 20));

    if (mounted) {
      context.router.replace(const HomeRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
