import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:synapsis_survei/domain/usecases/login_usecase.dart';

import '../../helpers/dummy_data/test_login_dummy.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late LoginUsecase loginUsecase;
  late MockLoginRepository mockLoginRepository;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    loginUsecase = LoginUsecase(mockLoginRepository);
  });

  test('should get data user from repository when login success', () async {
    //arrange
    when(mockLoginRepository.postLogin(testEmail, testPassword))
        .thenAnswer((_) async => const Right(testLoginSuccessEntity));

    //act
    final result = await loginUsecase.login(testEmail, testPassword);

    //assert
    expect(result, const Right(testLoginSuccessEntity));
  });
}
