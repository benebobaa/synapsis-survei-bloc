import 'package:dartz/dartz.dart';
import 'package:synapsis_survei/core/error/failure.dart';
import 'package:synapsis_survei/domain/entities/all_survei_entity.dart';
import 'package:synapsis_survei/domain/entities/detail_survei_entity.dart';
import 'package:synapsis_survei/domain/repositories/survei_repository.dart';

class SurveiUsecase {
  final SurveiRepository _surveiRepository;

  SurveiUsecase(this._surveiRepository);

  Future<Either<Failure, AllSurveiEntity>> allSurvei() async {
    return await _surveiRepository.getAllSurvei();
  }

  Future<Either<Failure, DetailSurveiEntity>> detailSurvei(
      String surveiId) async {
    return await _surveiRepository.getDetailSurvei(surveiId);
  }

  Future<Either<Failure, String>> getCookie() async {
    return await _surveiRepository.getCookie();
  }

  Future<Either<Failure, void>> deleteCookie() async {
    return await _surveiRepository.deleteCookie();
  }
}
