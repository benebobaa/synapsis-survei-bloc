import 'package:equatable/equatable.dart';
import 'package:synapsis_survei/domain/entities/detail_survei_entity.dart';
import 'package:synapsis_survei/domain/entities/survei_answer_entity.dart';

abstract class DetailSurveiState extends Equatable {
  const DetailSurveiState();

  @override
  List<Object?> get props => [];
}

class DetailSurveiInitial extends DetailSurveiState {
  final int currentQuestion;
  final SurveiAnswerEntity surveiAnswerEntity;
  const DetailSurveiInitial(this.currentQuestion, this.surveiAnswerEntity);

  @override
  List<Object?> get props => [currentQuestion];
}

class DetailSurveiLoading extends DetailSurveiState {}

class DetailSurveiLoaded extends DetailSurveiState {
  final DetailSurveiEntity result;
  final int index;
  final SurveiAnswerEntity surveiAnswerEntity;
  const DetailSurveiLoaded(this.result, this.index, this.surveiAnswerEntity);

  @override
  List<Object?> get props => [result, index,surveiAnswerEntity];
}

class DetailSurveiLoadFailure extends DetailSurveiState {
  final String message;

  const DetailSurveiLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
