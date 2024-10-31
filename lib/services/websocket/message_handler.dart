import 'dart:convert';

void handleMessage(dynamic message) async {
  final jsonData = jsonDecode(message);
  print(jsonData);
  switch (jsonData['command']) {
    case "send-message":
      break;
    case "receive-message":
      break;
    case "get-user-groups":
      break;
    default:
  }
}
