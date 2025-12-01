import 'dart:async';

import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/data/collectivity/collectivity_repository.dart';
import 'package:chat_app/features/chat/models/chat_base.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'collectivity_state.dart';

part 'collectivity_controller.g.dart';

@Riverpod(keepAlive: true)
class CollectivityController extends _$CollectivityController {
  late final CollectivityRepository collectivityRepository = getIt<CollectivityRepository>();
  StreamSubscription? _collectivitySubscription;

  @override
  CollectivityState build() {
    _setupListeners();
    ref.onDispose(() {
      _collectivitySubscription?.cancel();
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
  }
}
