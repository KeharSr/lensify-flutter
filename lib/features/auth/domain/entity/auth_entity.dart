import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final String userName;
  final String? password;
  final String? profilePicture;

  const AuthEntity({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.userName,
     this.password,
    this.profilePicture,
  });

  const AuthEntity.empty()
      : this(
          firstName: '',
          lastName: '',
          email: '',
          phoneNumber: '',
          userName: '',
          password: '',
          profilePicture: '',
        );

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phoneNumber,
        userName,
        password,
        profilePicture
      ];
}
