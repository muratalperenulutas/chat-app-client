import 'package:chat_app/data/collectivity/collectivity_abstract.dart';
import 'package:chat_app/features/chat/models/chat_base.dart';

class CollectivityState {
  final List<Collectivity> collectivities;
  final List<ChatBase> chatBaseModels;

  CollectivityState({
    this.collectivities = const [],
    this.chatBaseModels = const [],
  });

  CollectivityState copyWith({
    List<Collectivity>? collectivities,
    List<ChatBase>? chatBaseModels,
  }) {
    return CollectivityState(
      collectivities: collectivities ?? this.collectivities,
      chatBaseModels: chatBaseModels ?? this.chatBaseModels,
    );
  }
}
