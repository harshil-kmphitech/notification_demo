import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


@module
abstract class RegisterModule {
  @singleton
  Dio dio() => Dio(
    BaseOptions(
      sendTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      connectTimeout: const Duration(seconds: 20),
      headers: {
        'versioncode': '1',
        'devicetype': switch (Platform.operatingSystem) {
          'android' => 'Android',
          'ios' => 'iOS',
          _ => 'Other',
        },
      },
    ),
  );

  @preResolve
  Future<SharedPreferences> pref() => SharedPreferences.getInstance();

  @preResolve
  Future<FirebaseApp> initializeFireBase() => Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform
  );
}
