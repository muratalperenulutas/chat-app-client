// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collectivity_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(collectivityService)
const collectivityServiceProvider = CollectivityServiceProvider._();

final class CollectivityServiceProvider extends $FunctionalProvider<
    CollectivityService,
    CollectivityService,
    CollectivityService> with $Provider<CollectivityService> {
  const CollectivityServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'collectivityServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$collectivityServiceHash();

  @$internal
  @override
  $ProviderElement<CollectivityService> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CollectivityService create(Ref ref) {
    return collectivityService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectivityService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectivityService>(value),
    );
  }
}

String _$collectivityServiceHash() =>
    r'be0942663ae079413ab897438cfcf76bc6253a31';
