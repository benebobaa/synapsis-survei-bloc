import 'package:dartz/dartz.dart';
import 'package:synapsis_survei/core/error/failure.dart';
import 'package:synapsis_survei/domain/entities/login_success_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginSuccessEntity>> postLogin(
      String email, String password);
  Future<Either<Failure, String>> getEmailCache(String key);
  Future<Either<Failure, void>> saveEmailCache(String key, String email);
  Future<Either<Failure, String>> loginFingerprint(String key);
  Future<Either<Failure, String>> checkTokenExpired(String key);
  Future<Either<Failure, void>> deleteCookie(String key);

}
