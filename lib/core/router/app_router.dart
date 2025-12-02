import 'package:auto_route/auto_route.dart';
import 'package:chat_app/features/auth/screens/login_screen.dart';
import 'package:chat_app/features/auth/screens/loading_screen.dart';
import 'package:chat_app/features/auth/screens/register_screen.dart';
import 'package:chat_app/features/chat/screens/chat_page.dart';
import 'package:chat_app/features/chat/models/chat_base.dart';
import 'package:chat_app/features/home/screens/home_screen.dart';
import 'package:chat_app/features/person/screens/add_contact_page.dart';
import 'package:chat_app/features/person/screens/collectivity_detail_page.dart';
import 'package:chat_app/features/person/screens/create_group_page.dart';
import 'package:chat_app/features/person/screens/person_detail_page.dart';
import 'package:chat_app/features/person/models/person_base.dart';
import 'package:chat_app/features/person/screens/start_conversation_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  bool? _lastAuthState;

  void syncAuthRoute(bool isLoggedIn) {
    if (_lastAuthState == isLoggedIn) return;
    _lastAuthState = isLoggedIn;
    final targetRoute =
        isLoggedIn ? const LoadingRoute() : const LoginRoute();
    replaceAll([targetRoute]);
    
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: LoadingRoute.page, path: '/loading'),
        AutoRoute(page: RegisterRoute.page, path: '/register'),
        AutoRoute(page: HomeRoute.page, path: '/home'),
        AutoRoute(page: ChatRoute.page, path: '/chat'),
        AutoRoute(page: PersonDetailRoute.page, path: '/person-detail'),
        AutoRoute(page: CollectivityDetailRoute.page, path: '/collectivity-detail'),
        AutoRoute(page: CreateGroupRoute.page, path: '/create-group'),
        AutoRoute(page: AddContactsRoute.page, path: '/add-contact'),
        AutoRoute(page: StartConversationRoute.page, path: '/start-conversation'),
        RedirectRoute(path: '/', redirectTo: '/login'),
      ];
}
