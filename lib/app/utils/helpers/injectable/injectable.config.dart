// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_core/firebase_core.dart' as _i982;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:notification_demo/app/controllers/notifications_controller.dart'
    as _i313;
import 'package:notification_demo/app/data/services/pushNotificationServices/push_notification_services.dart'
    as _i1055;
import 'package:notification_demo/app/utils/helpers/injectable%20properties/injectable_properties.dart'
    as _i657;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.pref(),
      preResolve: true,
    );
    await gh.factoryAsync<_i982.FirebaseApp>(
      () => registerModule.initializeFireBase(),
      preResolve: true,
    );
    gh.singleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i313.NotificationsController>(
      () => _i313.NotificationsController(),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i1055.PushNotification>(
      () => _i1055.PushNotification(gh<_i361.Dio>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i657.RegisterModule {}
