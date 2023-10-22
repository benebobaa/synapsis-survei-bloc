import 'package:equatable/equatable.dart';
import 'package:synapsis_survei/domain/entities/survei_answer_entity.dart';

abstract class DetailSurveiEvent extends Equatable {
  const DetailSurveiEvent();

  @override
  List<Object?> get props => [];
}

class OnGetDetailSurvei extends DetailSurveiEvent {
  final String surveiId;
  const OnGetDetailSurvei(this.surveiId);

  @override
  List<Object?> get props => [];
}

class OnNextQuestion extends DetailSurveiEvent {
  // final int currentQuestion;
  // const OnNextQuestion(this.currentQuestion);

  // @override
  // List<Object?> get props => [currentQuestion];
}

class OnBackQuestion extends DetailSurveiEvent {
  // final int currentQuestion;
  // const OnNextQuestion(this.currentQuestion);

  // @override
  // List<Object?> get props => [currentQuestion];
}

class OnSubmitSurvei extends DetailSurveiEvent {
  // final int currentQuestion;
  // const OnNextQuestion(this.currentQuestion);

  // @override
  // List<Object?> get props => [currentQuestion];
}

class OnAnswerQuestion extends DetailSurveiEvent {
  final DataSurveiAnswerEntity data;
  const OnAnswerQuestion(this.data);

  @override
  List<Object?> get props => [data];
}