// Mocks generated by Mockito 5.4.4 from annotations
// in final_assignment/test/unit_test/auth_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i4;
import 'package:final_assignment/core/failure/failure.dart' as _i7;
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart'
    as _i3;
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart'
    as _i8;
import 'package:final_assignment/features/auth/domain/repository/auth_repository.dart'
    as _i2;
import 'package:final_assignment/features/auth/domain/usecase/auth_usecase.dart'
    as _i5;
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart'
    as _i9;
import 'package:final_assignment/features/auth/presentation/navigator/register_navigator.dart'
    as _i10;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeIAuthRepository_0 extends _i1.SmartFake
    implements _i2.IAuthRepository {
  _FakeIAuthRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUserSharedPrefs_1 extends _i1.SmartFake
    implements _i3.UserSharedPrefs {
  _FakeUserSharedPrefs_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_2<L, R> extends _i1.SmartFake implements _i4.Either<L, R> {
  _FakeEither_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthUseCase extends _i1.Mock implements _i5.AuthUseCase {
  @override
  _i2.IAuthRepository get authRepository => (super.noSuchMethod(
        Invocation.getter(#authRepository),
        returnValue: _FakeIAuthRepository_0(
          this,
          Invocation.getter(#authRepository),
        ),
        returnValueForMissingStub: _FakeIAuthRepository_0(
          this,
          Invocation.getter(#authRepository),
        ),
      ) as _i2.IAuthRepository);

  @override
  _i3.UserSharedPrefs get userSharedPrefs => (super.noSuchMethod(
        Invocation.getter(#userSharedPrefs),
        returnValue: _FakeUserSharedPrefs_1(
          this,
          Invocation.getter(#userSharedPrefs),
        ),
        returnValueForMissingStub: _FakeUserSharedPrefs_1(
          this,
          Invocation.getter(#userSharedPrefs),
        ),
      ) as _i3.UserSharedPrefs);

  @override
  _i6.Future<_i4.Either<_i7.Failure, bool>> createUser(_i8.AuthEntity? user) =>
      (super.noSuchMethod(
        Invocation.method(
          #createUser,
          [user],
        ),
        returnValue: _i6.Future<_i4.Either<_i7.Failure, bool>>.value(
            _FakeEither_2<_i7.Failure, bool>(
          this,
          Invocation.method(
            #createUser,
            [user],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i4.Either<_i7.Failure, bool>>.value(
                _FakeEither_2<_i7.Failure, bool>(
          this,
          Invocation.method(
            #createUser,
            [user],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i7.Failure, bool>>);

  @override
  _i6.Future<_i4.Either<_i7.Failure, bool>> loginUser(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #loginUser,
          [
            email,
            password,
          ],
        ),
        returnValue: _i6.Future<_i4.Either<_i7.Failure, bool>>.value(
            _FakeEither_2<_i7.Failure, bool>(
          this,
          Invocation.method(
            #loginUser,
            [
              email,
              password,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i4.Either<_i7.Failure, bool>>.value(
                _FakeEither_2<_i7.Failure, bool>(
          this,
          Invocation.method(
            #loginUser,
            [
              email,
              password,
            ],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i7.Failure, bool>>);

  @override
  _i6.Future<_i4.Either<_i7.Failure, _i8.AuthEntity>> getCurrentUser() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentUser,
          [],
        ),
        returnValue: _i6.Future<_i4.Either<_i7.Failure, _i8.AuthEntity>>.value(
            _FakeEither_2<_i7.Failure, _i8.AuthEntity>(
          this,
          Invocation.method(
            #getCurrentUser,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i4.Either<_i7.Failure, _i8.AuthEntity>>.value(
                _FakeEither_2<_i7.Failure, _i8.AuthEntity>(
          this,
          Invocation.method(
            #getCurrentUser,
            [],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i7.Failure, _i8.AuthEntity>>);

  @override
  _i6.Future<_i4.Either<_i7.Failure, bool>> fingerPrintLogin() =>
      (super.noSuchMethod(
        Invocation.method(
          #fingerPrintLogin,
          [],
        ),
        returnValue: _i6.Future<_i4.Either<_i7.Failure, bool>>.value(
            _FakeEither_2<_i7.Failure, bool>(
          this,
          Invocation.method(
            #fingerPrintLogin,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i4.Either<_i7.Failure, bool>>.value(
                _FakeEither_2<_i7.Failure, bool>(
          this,
          Invocation.method(
            #fingerPrintLogin,
            [],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i7.Failure, bool>>);
}

/// A class which mocks [LoginViewNavigator].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginViewNavigator extends _i1.Mock
    implements _i9.LoginViewNavigator {}

/// A class which mocks [RegisterViewNavigator].
///
/// See the documentation for Mockito's code generation for more information.
class MockRegisterViewNavigator extends _i1.Mock
    implements _i10.RegisterViewNavigator {}
