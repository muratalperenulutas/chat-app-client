// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MessageController)
const messageControllerProvider = MessageControllerProvider._();

final class MessageControllerProvider
    extends $NotifierProvider<MessageController, MessageState> {
  const MessageControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'messageControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$messageControllerHash();

  @$internal
  @override
  MessageController create() => MessageController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MessageState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MessageState>(value),
    );
  }
}

String _$messageControllerHash() => r'd470f525969fd7b02703be64103c8dde460f74cd';

abstract class _$MessageController extends $Notifier<MessageState> {
  MessageState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<MessageState, MessageState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<MessageState, MessageState>,
        MessageState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
