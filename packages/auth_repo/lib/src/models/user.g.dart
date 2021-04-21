// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id']);
  return User(
    id: json['id'] as String,
    email: json['email'] as String?,
    name: json['name'] as String?,
    photo: json['photo'] as String?,
    dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
    organization: json['organization'] as String?,
    provideEmergencyServices: json['provideEmergencyServices'] as bool?,
    serviceTimeStart: json['serviceTimeStart'] as String?,
    serviceTimeEnd: json['serviceTimeEnd'] as String?,
    serviceDays: json['serviceDays'] as String?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'photo': instance.photo,
      'dob': instance.dob?.toIso8601String(),
      'organization': instance.organization,
      'provideEmergencyServices': instance.provideEmergencyServices,
      'serviceTimeStart': instance.serviceTimeStart,
      'serviceTimeEnd': instance.serviceTimeEnd,
      'serviceDays': instance.serviceDays,
    };
