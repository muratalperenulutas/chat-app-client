enum WsMessageResponseType {
  USER_FOUND,
  MESSAGE_SEND,
  NEW_MESSAGE,
  GROUP_CREATED,
  NEW_GROUP,
  DYAD_CREATED,
  NEW_DYAD;

  const WsMessageResponseType();

  @override
  String toString() {
    return name;
  }

  static WsMessageResponseType fromString(String value) {
    for (WsMessageResponseType command in WsMessageResponseType.values) {
      if (command.name == value) {
        print(command.name);
        return command;
      }
    }
    throw ArgumentError("Invalid CommandResponseEnum value: $value");
  }
}
