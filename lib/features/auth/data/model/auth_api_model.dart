import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

//provider
final authApiModelProvider =
    Provider<AuthApiModel>((ref) => const AuthApiModel.empty());

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String userName;
  final String? password;

  AuthApiModel({
    required this.id,
    required this.firstName,
    required this.email,
    required this.lastName,
    required this.phoneNumber,
    required this.userName,
    required this.password,
  });

  const AuthApiModel.empty()
      : id = '',
        firstName = '',
        lastName = '',
        email = '',
        phoneNumber = '',
        userName = '',
        password = '';

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      userName: userName,
      password: password ?? '',
    );
  }

  //Convert Entity to API Object
  AuthApiModel fromEntity(AuthEntity entity) {
    return AuthApiModel(
      id: entity.id ?? '',
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      userName: entity.userName,
      password: entity.password,
    );
  }

  //Convert API List to Entity List
  List<AuthEntity> toEntityList(List<AuthApiModel> apiList) {
    return apiList.map((api) => api.toEntity()).toList();
  }

  @override
  List<Object?> get props =>
      [id, firstName, lastName, email, phoneNumber, userName, password];
}
