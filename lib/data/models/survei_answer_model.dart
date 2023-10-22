import 'package:synapsis_survei/domain/entities/survei_answer_entity.dart';

class SurveiAnswerModel extends SurveiAnswerEntity {
  const SurveiAnswerModel({
    required String surveiId,
    required List<DataSurveiAnswerModel> data,
  }) : super(
          surveiId: surveiId,
          data: data,
        );

  factory SurveiAnswerModel.fromJson(Map<String, dynamic> json) {
    return SurveiAnswerModel(
      surveiId: json['survei_id'] as String,
      data: (json['answers'] as List<dynamic>)
          .map((e) => DataSurveiAnswerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'survei_id': surveiId,
        'answers': data.map((e) => e.toJson()).toList(),
      };

  SurveiAnswerEntity toEntity() => SurveiAnswerEntity(
        surveiId: surveiId,
        data: data.map((e) => e.toEntity()).toList(),
      );
}

// ignore: must_be_immutable
class DataSurveiAnswerModel extends DataSurveiAnswerEntity {
  DataSurveiAnswerModel(
      {required String questionId, required String answer, required int value})
      : super(
          questionId: questionId,
          answer: answer,
          value: value,
        );

  factory DataSurveiAnswerModel.fromJson(Map<String, dynamic> json) {
    return DataSurveiAnswerModel(
      questionId: json['question_id'] as String,
      answer: json['answer'] as String,
      value: json['value'] as int,
    );
  }
}
