// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_current_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCurrentUserDto _$GetCurrentUserDtoFromJson(Map<String, dynamic> json) =>
    GetCurrentUserDto(
      id: json['_id'] as String,
      firstName: json['firstName'] as String,
      email: json['email'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String,
      userName: json['userName'] as String,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$GetCurrentUserDtoToJson(GetCurrentUserDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'userName': instance.userName,
      'password': instance.password,
    };
