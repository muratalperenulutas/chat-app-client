// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(participantService)
const participantServiceProvider = ParticipantServiceProvider._();

final class ParticipantServiceProvider extends $FunctionalProvider<
    ParticipantService,
    ParticipantService,
    ParticipantService> with $Provider<ParticipantService> {
  const ParticipantServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'participantServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$participantServiceHash();

  @$internal
  @override
  $ProviderElement<ParticipantService> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ParticipantService create(Ref ref) {
    return participantService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ParticipantService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ParticipantService>(value),
    );
  }
}

String _$participantServiceHash() =>
    r'3cc4fcd998f78593a1caa125b5fb918eb7e2608a';
