// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collectivity_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CollectivityController)
const collectivityControllerProvider = CollectivityControllerProvider._();

final class CollectivityControllerProvider
    extends $NotifierProvider<CollectivityController, CollectivityState> {
  const CollectivityControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'collectivityControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$collectivityControllerHash();

  @$internal
  @override
  CollectivityController create() => CollectivityController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectivityState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectivityState>(value),
    );
  }
}

String _$collectivityControllerHash() =>
    r'8e6368c7fb8bf30db213c1234c61a85b5c6ab28e';

abstract class _$CollectivityController extends $Notifier<CollectivityState> {
  CollectivityState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CollectivityState, CollectivityState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<CollectivityState, CollectivityState>,
        CollectivityState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
