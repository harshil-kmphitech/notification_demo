import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification_demo/logger.dart';
import 'package:notification_demo/send_notification.dart';

import 'notificationClass/notification_class.dart';
import 'notificationClass/onesignual.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  await OneSignalHelper.instance.initialize();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(title: 'Notification Demo', theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)), home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () => Get.offAll(() => const SendNotification()));
    _initializeApp();
    super.initState();
  }

  Future<void> _initializeApp() async {
    try {
      await Firebase.initializeApp();
      'Firebase initialized'.log;
    } catch (e) {
      'Firebase initialization failed: $e'.log;
      return;
    }

    NotificationService().initialize();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: FlutterLogo(size: 200)));
  }
}
