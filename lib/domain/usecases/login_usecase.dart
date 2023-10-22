import 'package:dartz/dartz.dart';
import 'package:synapsis_survei/core/error/failure.dart';
import 'package:synapsis_survei/domain/entities/login_success_entity.dart';
import 'package:synapsis_survei/domain/repositories/login_repository.dart';

class LoginUsecase {
  final LoginRepository _loginRepository;

  LoginUsecase(this._loginRepository);

  Future<Either<Failure, LoginSuccessEntity>> login(
      String email, String password) async {
    return await _loginRepository.postLogin(email, password);
  }

  Future<Either<Failure, String>> getEmailCache(String key) async {
    return await _loginRepository.getEmailCache(key);
  }

  Future<Either<Failure, void>> saveEmailCache(String key, String email) async {
    return await _loginRepository.saveEmailCache(key, email);
  }
}
