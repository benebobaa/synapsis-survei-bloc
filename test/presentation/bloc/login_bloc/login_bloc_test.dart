import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:synapsis_survei/core/error/failure.dart';
import 'package:synapsis_survei/domain/entities/login_success_entity.dart';
import 'package:synapsis_survei/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:synapsis_survei/presentation/bloc/login_bloc/login_event.dart';
import 'package:synapsis_survei/presentation/bloc/login_bloc/login_state.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockLoginUsecase mockLoginUsecase;
  late LoginBloc loginBloc;

  setUp(() {
    mockLoginUsecase = MockLoginUsecase();
    loginBloc = LoginBloc(mockLoginUsecase);
  });

  const testLoginSuccessEntity = LoginSuccessEntity(
    code: 200,
    status: true,
    message: 'success',
    data: DataLoginEntity(occupationLevel: 3, occupationName: 'Relawan'),
  );

  const testEmail = 'budimanobsight@gmail.com';
  const testPassword = 'password';

  test('initialState should be empty', () async {
    expect(loginBloc.state, LoginInitial());
  });

  blocTest('should emit [LoginLoading, LoginSuccess] when login success',
      build: () {
        when(mockLoginUsecase.login(testEmail, testPassword))
            .thenAnswer((_) async => const Right(testLoginSuccessEntity));
        return loginBloc;
      },
      act: (bloc) =>
          bloc.add(const OnLogin(email: testEmail, password: testPassword)),
      expect: () {
        return [
          LoginLoading(),
          const LoginSuccess(testLoginSuccessEntity),
        ];
      });

  blocTest('should emit [LoginLoading, LoginFailure] when login failed',
      build: () {
        when(mockLoginUsecase.login(testEmail, testPassword)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return loginBloc;
      },
      act: (bloc) =>
          bloc.add(const OnLogin(email: testEmail, password: testPassword)),
      expect: () {
        return [
          LoginLoading(),
          const LoginFailure('Server Failure'),
        ];
      });
}
