enum SourceEnum {
  LOCAL,
  SERVER;

  static SourceEnum fromString(String value) {
    for (SourceEnum source in SourceEnum.values) {
      if (source.name == value) {
        return source;
      }
    }
    throw ArgumentError("Invalid SourceEnum value: $value");
  }
}
