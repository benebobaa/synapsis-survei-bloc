import 'package:dartz/dartz.dart';
import 'package:synapsis_survei/core/error/failure.dart';
import 'package:synapsis_survei/domain/entities/all_survei_entity.dart';
import 'package:synapsis_survei/domain/entities/detail_survei_entity.dart';

abstract class SurveiRepository {
  Future<Either<Failure, AllSurveiEntity>> getAllSurvei();
  Future<Either<Failure, DetailSurveiEntity>> getDetailSurvei(String surveiId);
  Future<Either<Failure, String>> getCookie();
  Future<Either<Failure, void>> deleteCookie();
}
