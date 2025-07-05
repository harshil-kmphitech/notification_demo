// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      version: json['version'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      isSuccess: json['isSuccess'] as bool?,
      data:
          json['data'] == null
              ? null
              : NotificationsTotalRecord.fromJson(
                json['data'] as Map<String, dynamic>,
              ),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'version': instance.version,
      'statusCode': instance.statusCode,
      'isSuccess': instance.isSuccess,
      'data': instance.data,
      'message': instance.message,
    };

NotificationsTotalRecord _$NotificationsTotalRecordFromJson(
  Map<String, dynamic> json,
) => NotificationsTotalRecord(
  totalRecords: (json['totalRecords'] as num?)?.toInt(),
  notifications:
      (json['notifications'] as List<dynamic>?)
          ?.map((e) => NotiData.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$NotificationsTotalRecordToJson(
  NotificationsTotalRecord instance,
) => <String, dynamic>{
  'totalRecords': instance.totalRecords,
  'notifications': instance.notifications,
};

NotiData _$NotiDataFromJson(Map<String, dynamic> json) => NotiData(
  id: json['_id'] as String?,
  data:
      json['data'] == null
          ? null
          : NotificationData.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String?,
  image: json['image'] as String?,
  isRead: json['isRead'] as bool?,
  updatedAt: json['updatedAt'] as String?,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$NotiDataToJson(NotiData instance) => <String, dynamic>{
  '_id': instance.id,
  'data': instance.data,
  'message': instance.message,
  'image': instance.image,
  'isRead': instance.isRead,
  'updatedAt': instance.updatedAt,
  'createdAt': instance.createdAt?.toIso8601String(),
};

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) =>
    NotificationData(
      name: json['name'] as String?,
      email: json['email'] as String?,
      type: json['type'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'type': instance.type,
      'image': instance.image,
    };
