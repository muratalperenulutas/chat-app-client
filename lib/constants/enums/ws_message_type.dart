enum WsMessageType {
  FIND_USER,
  SEND_MESSAGE,
  CREATE_GROUP,
  CREATE_DYAD;

  const WsMessageType();

  @override
  String toString() {
    return name;
  }

  static WsMessageType fromString(String value) {
    for (WsMessageType command in WsMessageType.values) {
      if (command.name == value) {
        return command;
      }
    }
    throw ArgumentError("Invalid CommandEnum value: $value");
  }
}
