import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:notification_demo/app/utils/helpers/logger.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

import '../app/ui/pages/notification_screen.dart';

///
/// Initialize the NotificationService in main.dart
///
/// NotificationService().initialize();
///

class NotificationService {
  void initialize() async {
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

  final AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('@drawable/ic_stat_name');

  final DarwinInitializationSettings initializationSettingsIOS = const DarwinInitializationSettings();

  bool isFlutterLocalNotificationsInitialized = false;

  Future<void> init() async {
    _listenToForegroundMessages();
    await _setupNotificationChannel();
    await _initializeLocalNotifications();
    await _configureFirebaseMessaging();
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
    FirebaseMessaging.onMessage.listen((message) async {
      final notification = message.notification;
      final androidNotification = message.notification?.android;

      '=-=-=-=-=-=-${notification?.android?.imageUrl}'.log;

      if (notification != null && androidNotification != null && !kIsWeb) {
        // Check for image URL.
        final imageUrl = androidNotification.imageUrl;

        AndroidNotificationDetails androidDetails;

        if (imageUrl != null && imageUrl.isNotEmpty) {
          final bigPictureBitmap = await _getBitmapFromUrl(imageUrl);
          if (bigPictureBitmap != null) {
            androidDetails = AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              playSound: true,
              icon: '@drawable/ic_stat_name',
              color: const Color(0xFFFF5500),
              colorized: false,
              styleInformation: BigPictureStyleInformation(
                bigPictureBitmap,
                hideExpandedLargeIcon: true,
                contentTitle: notification.title,
                summaryText: notification.body,
              ),
            );
          } else {
            // fallback to normal style if download failed
            androidDetails = AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              playSound: true,
              // icon: '@drawable/ic_stat_name',
              color: const Color(0xFFFF5500),
              colorized: false,
            );
          }
        } else {
          androidDetails = AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            playSound: true,
            // icon: '@drawable/ic_stat_name',
            color: const Color(0xFFFF5500),
            colorized: false,
          );
        }

        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(android: androidDetails),
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

  static Future<void> backgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
  }

  /// Download image from the provided [url] and convert it to [ByteArrayAndroidBitmap]
  Future<ByteArrayAndroidBitmap?> _getBitmapFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return ByteArrayAndroidBitmap(response.bodyBytes);
      }
    } catch (e) {
      'Error downloading notification image: $e'.log;
    }
    // Fallback to an empty transparent image if download fails
    return null;
  }
}

class NotificationDevice {
  static String? deviceToken;
}