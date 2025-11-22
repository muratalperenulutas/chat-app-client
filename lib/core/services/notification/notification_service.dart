import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/shared_pref_key.dart';
import 'firebase_messaging_config.dart';


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (!kIsWeb) {
    await NotificationService.instance.setupFlutterNotifications();
  }
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;

  Future<void> initialize() async {
    // Background message handler
    if (!kIsWeb) {
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    }

    // Request permission
    await _requestNotificationPermissions();

    // Set up foreground & background handlers
    await _setupMessageHandlers();

    // Setup local notification (only for non-web platforms)
    if (!kIsWeb) {
      await setupFlutterNotifications();
    }

    // Print FCM token
    try {
      String? vapidKey;
      if (kIsWeb && FirebaseMessagingConfig.vapidKey.isNotEmpty) {
        vapidKey = FirebaseMessagingConfig.vapidKey;
        print('Using VAPID key for web FCM');
      }
      
      final token = await _messaging.getToken(
        vapidKey: vapidKey,
      );
      
      if (token != null) {
        print('FCM Token: $token');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(SharedPrefKey.fcmKey, token);
      } else {
        print('FCM Token is null');
      }
    } catch (e, stackTrace) {
      print("FCM error: $e");
    }
  }

  Future<void> _requestNotificationPermissions() async {
    final fcmSettings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );
    print('FCM Permission status: ${fcmSettings.authorizationStatus}');

    if (!kIsWeb) {
      final androidImpl = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      final granted = await androidImpl?.requestNotificationsPermission();
      if (granted != true) {
        print('Local notification permission not granted.');
      }
    } else {
      print('Web platform: Local notifications handled by browser.');
    }
  }

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) return;
    if (kIsWeb) return;

    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'Used for important notifications.',
      importance: Importance.high,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final iOSSettings = DarwinInitializationSettings();

    final initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        print('Notification payload: ${response.payload}');
      },
    );

    _isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> _setupMessageHandlers() async {
    // Foreground message
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });

    // Background & terminated message tap
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }

  void _handleNotificationTap(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      // Handle chat screen navigation
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    final notification = message.notification;
    final data=message.data;
    
    if (kIsWeb) {
      print('Web notification received: ${notification?.title ?? data.toString()}');
      return;
    }
    
    if (notification != null) {
      showLocalNotification(id: notification.hashCode, title: notification.title, body: notification.body,payload: data.toString());
    }else {
      showLocalNotification(id: data.hashCode, title: "data message", body: data.toString(),payload: data.toString());
    }
  }

  // Manual notification trigger (optional, for local-only notifications)
  Future<void> showLocalNotification({
    required int id,
    String? title,
    String? body,
    String? payload
  }) async {   
    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'Used for important notifications.',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',//notification.android?.smallIcon
    );

    const iOSDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }
}
