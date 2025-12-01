import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/data/collectivity/collectivity_repository.dart';
import 'package:chat_app/features/chat/models/chat_base.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'collectivity_state.dart';

part 'collectivity_controller.g.dart';

@Riverpod(keepAlive: true)
class CollectivityController extends _$CollectivityController {
  late final CollectivityRepository collectivityRepository = getIt<CollectivityRepository>();

  @override
  CollectivityState build() {
    //TO DO: Replace with more specific listener
    //generalChangeNotifier.isCollectivitiesChanged.addListener(listener);
    //generalChangeNotifier.isContactsChanged.addListener(listener);
    
    ref.onDispose(() {
      //generalChangeNotifier.isCollectivitiesChanged.removeListener(listener);
      //generalChangeNotifier.isContactsChanged.removeListener(listener);
    });

    _loadData();
    return CollectivityState();
  }

  Future<void> _loadData() async {
    final collectivities = await collectivityRepository.getCollectivities();
    final chatBaseModels = await ChatBase.fromCollectivities(collectivities);
    state = state.copyWith(
      collectivities: collectivities,
      chatBaseModels: chatBaseModels,
    );
  }
}
