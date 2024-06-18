import 'package:final_assignment/app/constants/hive_table_constants.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';


final authHiveModelProvider = Provider(
  (ref) => AuthHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String phone;

  @HiveField(5)
  final String userName;

  @HiveField(6)
  final String password;

  // Constructor
  AuthHiveModel({
    String? userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.userName,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  // empty constructor
  AuthHiveModel.empty()
      : this(
          userId: '',
          firstName: '',
          lastName: '',
          email: '',
          phone: '',
          userName: '',
          password: '',
        );

  // Convert Hive Object to Entity
  AuthEntity toEntity() => AuthEntity(
        id: userId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        userName: userName,
        password: password,
      );

  // Convert Entity to Hive Object
  AuthHiveModel toHiveModel(AuthEntity entity) => AuthHiveModel(
        userId: const Uuid().v4(),
        firstName: entity.firstName,
        lastName: entity.lastName,
        email: entity.email,
        phone: entity.phone,
        userName: entity.userName,
        password: entity.password,
      );

  // Convert Entity List to Hive List
  List<AuthHiveModel> toHiveModelList(List<AuthEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'userId: $userId, firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, userName: $userName, password: $password';
  }
}
