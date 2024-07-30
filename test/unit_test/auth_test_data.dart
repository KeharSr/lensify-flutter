import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';

class AuthTestData {
  AuthTestData._();

  static AuthEntity getAuthTestData() {
    return const AuthEntity(
      id: '668a6d8cd519d8fd3ec014de',
      firstName: 'Kehar',
      lastName: 'Singh',
      email: 'kehar@gmail.com',
      phoneNumber: '1234567890',
      userName: 'keharsr',
      password: '',
      
    );
  }
}
