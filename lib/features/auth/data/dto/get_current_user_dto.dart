import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_current_user_dto.g.dart';

@JsonSerializable()
class GetCurrentUserDto {
  final bool success;
  final String message;
  final AuthApiModel user;

  GetCurrentUserDto({
    required this.success,
    required this.message,
    required this.user,
  });

  Map<String, dynamic> toJson() => _$GetCurrentUserDtoToJson(this);

  factory GetCurrentUserDto.fromJson(Map<String, dynamic> json) =>
      _$GetCurrentUserDtoFromJson(json);
}
