import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:notification_demo/app/data/models/notificationModel/notification_model.dart';
import 'package:notification_demo/app/global/app_config.dart';
import 'package:retrofit/retrofit.dart';

part 'push_notification_services.g.dart';

/// Add base Url here..
@RestApi(parser: Parser.FlutterCompute, baseUrl: AppConfig.apiUrl)
@lazySingleton
abstract class PushNotification {
  @factoryMethod
  factory PushNotification(Dio dio) = _PushNotification;

  @GET(EndPoints.getNotifications)
  Future<NotificationModel> getNotifications({@Path() required int page, @Path() required int limit});

  @POST(EndPoints.pushNotification)
  Future<HttpResponse<dynamic>> pushNotification({@Field() required String deviceToken, @Field() required bool isImage});
}
