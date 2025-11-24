// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(personService)
const personServiceProvider = PersonServiceProvider._();

final class PersonServiceProvider
    extends $FunctionalProvider<PersonService, PersonService, PersonService>
    with $Provider<PersonService> {
  const PersonServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'personServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$personServiceHash();

  @$internal
  @override
  $ProviderElement<PersonService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PersonService create(Ref ref) {
    return personService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PersonService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PersonService>(value),
    );
  }
}

String _$personServiceHash() => r'459833c11c12bd142adbbf52f27bca0b46258a92';
