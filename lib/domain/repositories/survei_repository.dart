import 'package:dartz/dartz.dart';
import 'package:synapsis_survei/core/error/failure.dart';
import 'package:synapsis_survei/domain/entities/all_survei_entity.dart';
import 'package:synapsis_survei/domain/entities/detail_survei_entity.dart';

abstract class SurveiRepository {
  Future<Either<Failure, AllSurveiEntity>> getAllSurvei(String tokenKey);
  Future<Either<Failure, DetailSurveiEntity>> getDetailSurvei(String surveiId, String tokenKey);
  Future<Either<Failure, String>> getCookie(String key);
}
