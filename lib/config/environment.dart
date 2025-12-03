import 'dart:convert';
import 'package:flutter/services.dart';

class Environment {
  static const String dev = 'dev';
  static const String prod = 'prod';

  static String get fileName {
    const env = String.fromEnvironment('ENV', defaultValue: dev);
    return 'assets/config/$env.json';
  }

  static Future<Config> load() async {
    final contents = await rootBundle.loadString(fileName);
    final json = jsonDecode(contents);
    return Config.fromJson(json);
  }
}

class Config {
  final String appName;
  final String apiUrl;
  final String wsUrl;

  Config({
    required this.appName,
    required this.apiUrl,
    required this.wsUrl,
  });

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      appName: json['appName'] as String,
      apiUrl: json['apiUrl'] as String,
      wsUrl: json['wsUrl'] as String,
    );
  }
}
