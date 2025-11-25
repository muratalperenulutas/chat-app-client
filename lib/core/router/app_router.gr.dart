// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AddContactsPage]
class AddContactsRoute extends PageRouteInfo<void> {
  const AddContactsRoute({List<PageRouteInfo>? children})
      : super(AddContactsRoute.name, initialChildren: children);

  static const String name = 'AddContactsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AddContactsPage();
    },
  );
}

/// generated route for
/// [ChatPage]
class ChatRoute extends PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    Key? key,
    required ChatBase chatBase,
    List<PageRouteInfo>? children,
  }) : super(
          ChatRoute.name,
          args: ChatRouteArgs(key: key, chatBase: chatBase),
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatRouteArgs>();
      return ChatPage(key: args.key, chatBase: args.chatBase);
    },
  );
}

class ChatRouteArgs {
  const ChatRouteArgs({this.key, required this.chatBase});

  final Key? key;

  final ChatBase chatBase;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, chatBase: $chatBase}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChatRouteArgs) return false;
    return key == other.key && chatBase == other.chatBase;
  }

  @override
  int get hashCode => key.hashCode ^ chatBase.hashCode;
}

/// generated route for
/// [CollectivityDetailPage]
class CollectivityDetailRoute
    extends PageRouteInfo<CollectivityDetailRouteArgs> {
  CollectivityDetailRoute({
    required ChatBase chatBase,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CollectivityDetailRoute.name,
          args: CollectivityDetailRouteArgs(chatBase: chatBase, key: key),
          initialChildren: children,
        );

  static const String name = 'CollectivityDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CollectivityDetailRouteArgs>();
      return CollectivityDetailPage(chatBase: args.chatBase, key: args.key);
    },
  );
}

class CollectivityDetailRouteArgs {
  const CollectivityDetailRouteArgs({required this.chatBase, this.key});

  final ChatBase chatBase;

  final Key? key;

  @override
  String toString() {
    return 'CollectivityDetailRouteArgs{chatBase: $chatBase, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CollectivityDetailRouteArgs) return false;
    return chatBase == other.chatBase && key == other.key;
  }

  @override
  int get hashCode => chatBase.hashCode ^ key.hashCode;
}

/// generated route for
/// [CreateGroupPage]
class CreateGroupRoute extends PageRouteInfo<void> {
  const CreateGroupRoute({List<PageRouteInfo>? children})
      : super(CreateGroupRoute.name, initialChildren: children);

  static const String name = 'CreateGroupRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateGroupPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [PersonDetailPage]
class PersonDetailRoute extends PageRouteInfo<PersonDetailRouteArgs> {
  PersonDetailRoute({
    Key? key,
    required Person person,
    List<PageRouteInfo>? children,
  }) : super(
          PersonDetailRoute.name,
          args: PersonDetailRouteArgs(key: key, person: person),
          initialChildren: children,
        );

  static const String name = 'PersonDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PersonDetailRouteArgs>();
      return PersonDetailPage(key: args.key, person: args.person);
    },
  );
}

class PersonDetailRouteArgs {
  const PersonDetailRouteArgs({this.key, required this.person});

  final Key? key;

  final Person person;

  @override
  String toString() {
    return 'PersonDetailRouteArgs{key: $key, person: $person}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PersonDetailRouteArgs) return false;
    return key == other.key && person == other.person;
  }

  @override
  int get hashCode => key.hashCode ^ person.hashCode;
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterPage();
    },
  );
}

/// generated route for
/// [StartConversationPage]
class StartConversationRoute extends PageRouteInfo<void> {
  const StartConversationRoute({List<PageRouteInfo>? children})
      : super(StartConversationRoute.name, initialChildren: children);

  static const String name = 'StartConversationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const StartConversationPage();
    },
  );
}
