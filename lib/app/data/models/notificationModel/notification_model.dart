import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

NotificationModel deserializeNotificationModel(Map<String, dynamic> json) => NotificationModel.fromJson(json);

@JsonSerializable()
class NotificationModel {
  String? version;
  int? statusCode;
  bool? isSuccess;
  NotificationsTotalRecord? data;
  String? message;

  NotificationModel({
    this.version,
    this.statusCode,
    this.isSuccess,
    this.data,
    this.message,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

@JsonSerializable()
class NotificationsTotalRecord {
  int? totalRecords;
  List<NotiData>? notifications;

  NotificationsTotalRecord({
    this.totalRecords,
    this.notifications,
  });

  factory NotificationsTotalRecord.fromJson(Map<String, dynamic> json) => _$NotificationsTotalRecordFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsTotalRecordToJson(this);
}

@JsonSerializable()
class NotiData {
  @JsonKey(name: "_id")
  String? id;
  NotificationData? data;
  String? message;
  String? image;
  bool? isRead;
  String? updatedAt;
  DateTime? createdAt;

  NotiData({
    this.id,
    this.data,
    this.message,
    this.image,
    this.isRead,
    this.updatedAt,
    this.createdAt,
  });

  factory NotiData.fromJson(Map<String, dynamic> json) => _$NotiDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotiDataToJson(this);
}

@JsonSerializable()
class NotificationData {
  String? name;
  String? email;
  String? type;
  String? image;

  NotificationData({
    this.name,
    this.email,
    this.type,
    this.image,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => _$NotificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);
}