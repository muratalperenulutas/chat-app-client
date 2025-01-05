enum SourceEnum {
  LOCAL,
  SERVER;

  @override
  String toString() {
    return name;
  }

  static SourceEnum fromString(String value) {
    for (SourceEnum source in SourceEnum.values) {
      if (source.name == value) {
        return source;
      }
    }
    throw ArgumentError("Invalid SourceEnum value: $value");
  }
}
