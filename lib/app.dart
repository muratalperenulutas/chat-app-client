import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/router/app_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final appRouter = getIt<AppRouter>();

    if (!getIt.isRegistered<ProviderContainer>()) {
      getIt.registerSingleton<ProviderContainer>(ref.container);
    }

    ref.listen(authControllerProvider, (previous, next) {
      if (next.isLoading) return;
      appRouter.syncAuthRoute(next.isLoggedIn);
    });

    if (!authState.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appRouter.syncAuthRoute(authState.isLoggedIn);
      });
    }

    if (authState.isLoading) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp.router(
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      routeInformationProvider: appRouter.routeInfoProvider(),
      debugShowCheckedModeBanner: false,
    );
  }
}
