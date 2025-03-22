import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

final List<Color> predefinedMessageCardColors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.purple,
  Colors.teal,
  Colors.pink,
  Colors.brown,
  Colors.amber,
  Colors.cyan,
  Colors.indigoAccent,
  Colors.lime,
  Colors.deepOrange,
  Colors.purpleAccent,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.yellow,
  Colors.grey,
  Colors.blueGrey,
];

class MessageCardColorHelper {
  static Color generateColorForUserValue(String userId, int value) {
    final combined = '$userId-$value';
    final hash = sha256.convert(utf8.encode(combined)).bytes;

    final r = 64 + (hash[0] % 128);
    final g = 64 + (hash[1] % 128);
    final b = 64 + (hash[2] % 128);

    return Color.fromARGB(255, r, g, b);
  }

  static Color getColorFromPredefined(String userId,int value) {
    final combined='$userId-$value';
    final hash = sha256.convert(utf8.encode(combined)).bytes;
    final index = hash[0] % predefinedMessageCardColors.length;
    return predefinedMessageCardColors[index];
  }
}
