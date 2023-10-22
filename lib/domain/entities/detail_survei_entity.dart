// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class DetailSurveiEntity extends Equatable {
  final int code;
  final bool status;
  final String message;
  final DataDetailSurveiEntity data;

  const DetailSurveiEntity({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  List<Object> get props => [code, status, message, data];
}

class DataDetailSurveiEntity extends Equatable {
  final String id;
  final String surveyName;
  final int status;
  final int totalRespondent;
  final String createdAt;
  final String updatedAt;
  final List<DetailQuestionsEntity> questions;
  const DataDetailSurveiEntity({
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

  DataDetailSurveiEntity toEntity() => DataDetailSurveiEntity(
        id: id,
        surveyName: surveyName,
        status: status,
        totalRespondent: totalRespondent,
        createdAt: createdAt,
        updatedAt: updatedAt,
        questions: questions,
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

class DetailQuestionsEntity extends Equatable {
  final String id;
  final int questionNumber;
  final String surveyId;
  final String section;
  final String inputType;
  final String questionName;
  final String questionSubject;
  final List<OptionsQuestionEntity> options;
  const DetailQuestionsEntity({
    required this.id,
    required this.questionNumber,
    required this.surveyId,
    required this.section,
    required this.inputType,
    required this.questionName,
    required this.questionSubject,
    required this.options,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'question_number': questionNumber,
        'survey_id': surveyId,
        'section': section,
        'input_type': inputType,
        'question_name': questionName,
        'question_subject': questionSubject,
        'options': List<dynamic>.from(options.map((x) => x.toJson())),
      };

  DetailQuestionsEntity toEntity() => DetailQuestionsEntity(
        id: id,
        questionNumber: questionNumber,
        surveyId: surveyId,
        section: section,
        inputType: inputType,
        questionName: questionName,
        questionSubject: questionSubject,
        options: options,
      );

  @override
  List<Object> get props {
    return [
      id,
      questionNumber,
      surveyId,
      section,
      inputType,
      questionName,
      questionSubject,
      options,
    ];
  }
}

class OptionsQuestionEntity extends Equatable {
  final String id;
  final String questionId;
  final String optionName;
  final int value;
  final String color;
  const OptionsQuestionEntity({
    required this.id,
    required this.questionId,
    required this.optionName,
    required this.value,
    required this.color,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'question_id': questionId,
        'option_name': optionName,
        'value': value,
        'color': color,
      };

  OptionsQuestionEntity toEntity() => OptionsQuestionEntity(
        id: id,
        questionId: questionId,
        optionName: optionName,
        value: value,
        color: color,
      );

  @override
  List<Object> get props {
    return [
      id,
      questionId,
      optionName,
      value,
      color,
    ];
  }
}
