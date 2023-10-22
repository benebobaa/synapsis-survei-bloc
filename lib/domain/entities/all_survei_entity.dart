import 'package:equatable/equatable.dart';

class AllSurveiEntity extends Equatable {
  final int code;
  final bool status;
  final String message;
  final int totalAllData;
  final List<DataAllSurveiEntity> data;

  const AllSurveiEntity({
    required this.code,
    required this.status,
    required this.message,
    required this.totalAllData,
    required this.data,
  });

  @override
  List<Object> get props {
    return [
      code,
      status,
      message,
      totalAllData,
      data,
    ];
  }
}

class DataAllSurveiEntity extends Equatable {
  final String id;
  final String surveyName;
  final int status;
  final int totalRespondent;
  final String createdAt;
  final String updatedAt;
  final List<QuestionsEntity> questions;
  const DataAllSurveiEntity({
    required this.id,
    required this.surveyName,
    required this.status,
    required this.totalRespondent,
    required this.createdAt,
    required this.updatedAt,
    required this.questions,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'survey_name': surveyName,
        'status': status,
        'total_respondent': totalRespondent,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'questions': List<dynamic>.from(questions.map((x) => x.toJson())),
      };

  DataAllSurveiEntity toEntity() => DataAllSurveiEntity(
        id: id,
        surveyName: surveyName,
        status: status,
        totalRespondent: totalRespondent,
        createdAt: createdAt,
        updatedAt: updatedAt,
        questions:
            List<QuestionsEntity>.from(questions.map((x) => x.toEntity())),
      );

  @override
  List<Object> get props {
    return [
      id,
      surveyName,
      status,
      totalRespondent,
      createdAt,
      updatedAt,
      questions,
    ];
  }
}

class QuestionsEntity extends Equatable {
  final String questionName;
  final String inputType;
  final String questionId;
  const QuestionsEntity({
    required this.questionName,
    required this.inputType,
    required this.questionId,
  });

  Map<String, dynamic> toJson() => {
        'question_name': questionName,
        'input_type': inputType,
        'question_id': questionId,
      };

  QuestionsEntity toEntity() => QuestionsEntity(
        questionName: questionName,
        inputType: inputType,
        questionId: questionId,
      );

  @override
  List<Object> get props => [questionName, inputType, questionId];
}
