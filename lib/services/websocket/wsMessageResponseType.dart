enum WsMessageResponseType {
  FIND_USER_RESPONSE,
  SEND_MESSAGE_RESPONSE,
  GET_GROUPS_RESPONSE,
  GET_MESSAGES_RESPONSE,
  CREATE_GROUP_RESPONSE;

  const WsMessageResponseType();

  @override
  String toString() {
    return name;
  }

  static WsMessageResponseType fromString(String value) {
    for (WsMessageResponseType command in WsMessageResponseType.values) {
      if (command.name == value) {
        return command;
      }
    }
    throw ArgumentError("Invalid CommandResponseEnum value: $value");
  }
}
