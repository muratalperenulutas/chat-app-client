import 'package:chat_app/app.dart';
import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:chat_app/core/bindings/initial_binding.dart';
import 'package:chat_app/config/environment.dart';
import 'package:chat_app/config/urls.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  appConfig = await Environment.load();
  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy());
  }

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }

  configureDependencies();

  final container = ProviderContainer();
  getIt.registerSingleton<ProviderContainer>(container);

  initInitialBindings();

  runApp(UncontrolledProviderScope(
    container: container,
    child: MyApp(),
  ));
}
