// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(messageService)
const messageServiceProvider = MessageServiceProvider._();

final class MessageServiceProvider
    extends $FunctionalProvider<MessageService, MessageService, MessageService>
    with $Provider<MessageService> {
  const MessageServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'messageServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$messageServiceHash();

  @$internal
  @override
  $ProviderElement<MessageService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MessageService create(Ref ref) {
    return messageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MessageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MessageService>(value),
    );
  }
}

String _$messageServiceHash() => r'4e7dbe892dd93d936c3f7038b58a82de96b18ea0';
