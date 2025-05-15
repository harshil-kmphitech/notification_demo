import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:notification_demo/logger.dart';

import '../notification_screen.dart';
import '../send_notification.dart';

///
/// Initialize the NotificationService in main.dart
///
/// NotificationService().initialize();
///


class NotificationService {

  void initialize() async{

    try {
      FirebaseMessaging.onBackgroundMessage(NotificationService.backgroundHandler);
    } catch (e) {
      'Background handler error: $e'.log;
    }

    await init();
    await getFirebaseTokenAndSave();
  }
  late AndroidNotificationChannel channel;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('@drawable/ic_notification');

  final DarwinInitializationSettings initializationSettingsIOS = const DarwinInitializationSettings();

  bool isFlutterLocalNotificationsInitialized = false;

  Future<void> init() async {
    await _setupNotificationChannel();
    await _initializeLocalNotifications();
    await _configureFirebaseMessaging();
    _listenToForegroundMessages();
  }

  Future<void> _setupNotificationChannel() async {
    if (isFlutterLocalNotificationsInitialized) return;

    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> _initializeLocalNotifications() async {
    final settings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        'Foreground payload: ${details.payload}'.log;
        _handleNavigation();
      },
    );
  }

  Future<void> _configureFirebaseMessaging() async {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      'Background payload: ${message.data}'.log;
      _handleNavigation();
    });

    final initialMessage = await firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      'App launched via notification: ${initialMessage.data}'.log;
      // _handleNavigation();
    }

    await firebaseMessaging.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
  }

  void _listenToForegroundMessages() {
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      final android = message.notification?.android;

      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              playSound: true,
              icon: '@drawable/ic_notification',
              color: Colors.blue,
              colorized: false,
            ),
          ),
          payload: notification.title,
        );
      }
    });
  }

  void _handleNavigation() => Get.to(() => NotificationScreen());

  Future<void> getFirebaseTokenAndSave() async {
    try {
      final token = await firebaseMessaging.getToken();
      NotificationDevice.deviceToken = token;
      if (token != null) {
        'Firebase Token: $token'.log;
      }
    } catch (e) {
      'Error fetching FCM token: $e'.log;
    }
  }

  static Future<void>   backgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
  }
}
