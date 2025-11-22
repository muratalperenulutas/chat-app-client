# chat_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

dart run drift_dev schema dump lib/data/database/database.dart drift_schemas/
flutter pub upgrade drift_dev build_runner
flutter clean && flutter pub get && flutter run -d chrome

flutter pub run build_runner build --delete-conflicting-outputs
flutter pub run build_runner build
