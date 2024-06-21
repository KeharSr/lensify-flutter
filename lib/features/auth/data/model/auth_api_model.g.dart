// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String,
      firstName: json['firstName'] as String,
      email: json['email'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String,
      userName: json['userName'] as String,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'userName': instance.userName,
      'password': instance.password,
    };
