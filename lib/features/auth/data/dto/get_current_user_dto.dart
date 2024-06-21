import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_current_user_dto.g.dart';

@JsonSerializable()
class GetCurrentUserDto{
  @JsonKey(name: '_id')
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String userName;
  final String? password;

  GetCurrentUserDto({
    required this.id,
    required this.firstName,
    required this.email,
    required this.lastName,
    required this.phone,
    required this.userName,
    required this.password,
  });

  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,      
      userName: userName,
      password: password ?? '',
    );
  }

  factory GetCurrentUserDto.fromJson(Map<String, dynamic> json) =>
      _$GetCurrentUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetCurrentUserDtoToJson(this);
}