
enum ChatPageBaseModelSource {
  contact("contact"),
  group("group"),
  directGroup("directGroup");

  final String value;

  const ChatPageBaseModelSource(this.value);

  @override
  String toString() {
    return value;
  }
}