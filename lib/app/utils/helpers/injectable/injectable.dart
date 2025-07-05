import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart' as i;
import 'package:notification_demo/app/utils/helpers/Interceptor/token_interceptor.dart';
import 'package:notification_demo/app/utils/helpers/injectable/injectable.config.dart';
import 'package:notification_demo/app/utils/helpers/loading.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final getIt = GetIt.instance;

@i.injectableInit
void configuration({required Widget myApp}) {
  runZonedGuarded(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      await getIt.init();

      unawaited(SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
      // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
      // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
      PlatformDispatcher.instance.onError = (error, stack) {
        log(error.toString(), stackTrace: stack);
        // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      if (kDebugMode) {
        getIt<Dio>().interceptors.add(PrettyDioLogger(requestBody: true, requestHeader: true));
      }

      getIt<Dio>().interceptors
        ..add(RefreshTokenInterceptor())
        ..add(RetryInterceptor(dio: getIt<Dio>()));

      Loading.configLoading();
      runApp(myApp);
    },
        (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      // FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true)
    },
    zoneSpecification: ZoneSpecification(
      handleUncaughtError: (Zone zone, ZoneDelegate delegate, Zone parent, Object error, StackTrace stackTrace) {
        log(error.toString(), stackTrace: stackTrace);
        // FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
      },
    ),
  );
}
