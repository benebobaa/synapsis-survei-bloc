// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SurveiAnswerEntity extends Equatable {
  final String surveiId;
  final List<DataSurveiAnswerEntity> data;
  const SurveiAnswerEntity({
    required this.surveiId,
    required this.data,
  });

  @override
  List<Object> get props => [surveiId, data];
}

// ignore: must_be_immutable
class DataSurveiAnswerEntity extends Equatable {
  final String questionId;
  String answer;
  int value;
  DataSurveiAnswerEntity({
    required this.questionId,
    required this.answer,
    required this.value,
  });

  Map<String, dynamic> toJson() => {
        'question_id': questionId,
        'answer': answer,
        'value': value,
      };

  DataSurveiAnswerEntity toEntity() => DataSurveiAnswerEntity(
        questionId: questionId,
        answer: answer,
        value: value,
      );

  @override
  List<Object> get props => [questionId, answer, value];
}
