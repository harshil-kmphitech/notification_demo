import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:notification_demo/app/data/services/pushNotificationServices/push_notification_services.dart';
import 'package:notification_demo/app/ui/pages/notification_screen.dart';
import 'package:notification_demo/app/utils/helpers/exception/exception.dart';
import 'package:notification_demo/app/utils/helpers/injectable/injectable.dart';
import 'package:notification_demo/notificationServices/notification_service.dart';

class SendNotification extends StatefulWidget {
  const SendNotification({super.key});

  @override
  State<SendNotification> createState() => _SendNotificationState();
}

class _SendNotificationState extends State<SendNotification> {
  @override
  void initState() {
    notificationPermission();
    super.initState();
  }

  void notificationPermission() async {
    await FirebaseMessaging.instance.requestPermission();
  }

  Future<void> pushNotificationApi({required bool isImage}) async {
    if(NotificationDevice.deviceToken?.isEmpty ?? true) await NotificationService().getFirebaseTokenAndSave();
    getIt<PushNotification>()
        .pushNotification(deviceToken: NotificationDevice.deviceToken ?? '', isImage: isImage)
        .handler(null, onSuccess: (value) async {}, onFailed: (value) => value.showToast());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [IconButton(icon: const Icon(Icons.notifications), onPressed: () => Get.to(() => NotificationScreen())).paddingOnly(right: 12)],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          TextButton(onPressed: () async => pushNotificationApi(isImage: false), child: const Text("Send Notification")),
          TextButton(onPressed: () async => pushNotificationApi(isImage: true), child: const Text("Send Notification with Image")),
        ],
      ),
    );
  }
}
