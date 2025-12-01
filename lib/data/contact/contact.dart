import 'package:chat_app/constants/enums/status.dart';

class Contact {
  final int? id;
  final String name;
  final String username;
  final String? personId;
  final Status status;

  Contact({
    this.id,
    required this.name,
    required this.username,
    this.personId,
    this.status = Status.created,
  });
}
