
enum ChatPageBaseModelSource {
  CONTACT("contact"),
  GROUP("group"),
  DIRECT_GROUP("directGroup");

  final String value;

  const ChatPageBaseModelSource(this.value);

  @override
  String toString() {
    return value;
  }
}