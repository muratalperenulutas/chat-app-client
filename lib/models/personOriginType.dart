
enum PersonOriginType {
  contact("contact"),
  server("server");

  final String value;

  const PersonOriginType(this.value);

  @override
  String toString() {
    return value;
  }
}