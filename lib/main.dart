import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:notification_demo/app/ui/pages/send_notification.dart';
import 'package:notification_demo/app/utils/helpers/extensions/extensions.dart';
import 'package:notification_demo/app/utils/helpers/logger.dart';
import 'package:notification_demo/l10n/app_localizations.dart';
import 'package:notification_demo/notificationServices/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/utils/helpers/injectable/injectable.dart';

void main() => configuration(myApp: const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: GetMaterialApp(
        home: const MyHomePage(),
        title: 'Notification Demo',
        debugShowCheckedModeBanner: false,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(getIt<SharedPreferences>().getAppLocal ?? 'ru'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,

        ///Default Theme
        themeMode: ThemeMode.light,
        builder: EasyLoading.init(),
      ),
    );
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
    Future.delayed(const Duration(seconds: 3), () async {
      Get.offAll(() => const SendNotification());
      await NotificationService().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: FlutterLogo(size: 200)));
  }
}
