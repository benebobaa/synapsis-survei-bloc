import 'package:dartz/dartz.dart';
import 'package:synapsis_survei/core/error/failure.dart';
import 'package:synapsis_survei/domain/entities/all_survei_entity.dart';
import 'package:synapsis_survei/domain/entities/detail_survei_entity.dart';
import 'package:synapsis_survei/domain/repositories/survei_repository.dart';

class SurveiUsecase {
  final SurveiRepository _surveiRepository;

  SurveiUsecase(this._surveiRepository);

  Future<Either<Failure, AllSurveiEntity>> allSurvei(String tokenKey) async {
    return await _surveiRepository.getAllSurvei(tokenKey);
  }

  Future<Either<Failure, DetailSurveiEntity>> detailSurvei(
      String surveiId, String tokenKey) async {
    return await _surveiRepository.getDetailSurvei(surveiId, tokenKey);
  }

  Future<Either<Failure, String>> getCookie(String key) async {
    return await _surveiRepository.getCookie(key);
  }

  
}
