// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PersonController)
const personControllerProvider = PersonControllerProvider._();

final class PersonControllerProvider
    extends $NotifierProvider<PersonController, PersonState> {
  const PersonControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'personControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$personControllerHash();

  @$internal
  @override
  PersonController create() => PersonController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PersonState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PersonState>(value),
    );
  }
}

String _$personControllerHash() => r'7aa3f908e8921d65415c7e344615d6bb6d47bed0';

abstract class _$PersonController extends $Notifier<PersonState> {
  PersonState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PersonState, PersonState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<PersonState, PersonState>, PersonState, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
