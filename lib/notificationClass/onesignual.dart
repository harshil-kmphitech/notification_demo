import 'dart:developer';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../notification_screen.dart';

class OneSignalHelper {
  OneSignalHelper._();
  static final OneSignalHelper instance = OneSignalHelper._();

  Future<void> initialize() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.initialize("9a6d82da-1928-4f2e-ab46-8c3ff3e376d2"); // Replace with your app ID

    // Foreground notifications
    OneSignal.Notifications.addForegroundWillDisplayListener(_onForegroundNotification);

    // Tapped notifications
    OneSignal.Notifications.addClickListener(_onNotificationClick);

    // Get Push Token (OneSignal Player ID)
    final userId = OneSignal.User.pushSubscription.id;
    log("📲 OneSignal Player ID: $userId");
  }

  void _onForegroundNotification(OSNotificationWillDisplayEvent event) {
    log('📥 Foreground Notification: ${event.notification.jsonRepresentation()}');
    // No need to manually call complete(); notification will be shown automatically.
  }

  void _onNotificationClick(OSNotificationClickEvent result) {
    final data = result.notification.additionalData;
    log('🔔 Notification Clicked: $data');
    _handleNavigation(data);
  }

  void _handleNavigation(Map<String, dynamic>? data) {
    if (data == null) return;
    final type = data['type'];
    if (type == 'Normal notification') {
      Future.delayed(Duration.zero, () => Get.to(() => NotificationScreen()));
    }
  }
}
