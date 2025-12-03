import 'dart:async';

import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/data/collectivity/collectivity_repository.dart';
import 'package:chat_app/data/contact/contact_repository.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:chat_app/features/chat/models/chat_base.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'collectivity_state.dart';

part 'collectivity_controller.g.dart';

@Riverpod(keepAlive: true)
class CollectivityController extends _$CollectivityController {
  late final CollectivityRepository collectivityRepository = getIt<CollectivityRepository>();
  late final PersonRepository personRepository = getIt<PersonRepository>();
  late final ContactRepository contactRepository = getIt<ContactRepository>();
  StreamSubscription? _collectivitySubscription;
  StreamSubscription? _personSubscription;
  StreamSubscription? _contactSubscription;

  @override
  CollectivityState build() {
    _setupListeners();
    ref.onDispose(() {
      _collectivitySubscription?.cancel();
      _personSubscription?.cancel();
      _contactSubscription?.cancel();
    });
    return CollectivityState();
  }

  void _setupListeners() {
    _collectivitySubscription = collectivityRepository.watchCollectivities().listen((collectivities) async {
      final chatBaseModels = await ChatBase.fromCollectivities(collectivities);
      state = state.copyWith(
        collectivities: collectivities,
        chatBaseModels: chatBaseModels,
      );
    });

    _personSubscription = personRepository.watchPersons().listen((persons) async {
      final chatBaseModels = await ChatBase.fromCollectivities(state.collectivities);
      state = state.copyWith(
        chatBaseModels: chatBaseModels,
      );
    });

    _contactSubscription = contactRepository.watchContacts().listen((contacts) async {
      final chatBaseModels = await ChatBase.fromCollectivities(state.collectivities);
      state = state.copyWith(
        chatBaseModels: chatBaseModels,
      );
    });
  }
}
