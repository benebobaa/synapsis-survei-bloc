import 'package:synapsis_survei/domain/entities/detail_survei_entity.dart';

class DetailSurveiModel extends DetailSurveiEntity {
  const DetailSurveiModel({
    required int code,
    required bool status,
    required String message,
    required DataDetailSurveiModel data,
  }) : super(code: code, status: status, message: message, data: data);

  factory DetailSurveiModel.fromJson(Map<String, dynamic> jsonMap) {
    return DetailSurveiModel(
      code: jsonMap['code'],
      status: jsonMap['status'],
      message: jsonMap['message'],
      data: DataDetailSurveiModel.fromJson(jsonMap['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'message': message,
        'data': data.toJson(),
      };

  DetailSurveiEntity toEntity() => DetailSurveiEntity(
        code: code,
        status: status,
        message: message,
        data: data.toEntity(),
      );
}

class DataDetailSurveiModel extends DataDetailSurveiEntity {
  const DataDetailSurveiModel({
    required String id,
    required String surveyName,
    required int status,
    required int totalRespondent,
    required String createdAt,
    required String updatedAt,
    required List<DetailQuestionsModel> questions,
  }) : super(
          id: id,
          surveyName: surveyName,
          status: status,
          totalRespondent: totalRespondent,
          createdAt: createdAt,
          updatedAt: updatedAt,
          questions: questions,
        );

  factory DataDetailSurveiModel.fromJson(Map<String, dynamic> jsonMap) {
    return DataDetailSurveiModel(
      id: jsonMap['id'],
      surveyName: jsonMap['survey_name'],
      status: jsonMap['status'],
      totalRespondent: jsonMap['total_respondent'],
      createdAt: jsonMap['created_at'],
      updatedAt: jsonMap['updated_at'],
      questions: List<DetailQuestionsModel>.from(
          jsonMap['questions'].map((x) => DetailQuestionsModel.fromJson(x))),
    );
  }
}

class DetailQuestionsModel extends DetailQuestionsEntity {
  const DetailQuestionsModel({
    required String id,
    required int questionNumber,
    required String surveyId,
    required String section,
    required String inputType,
    required String questionName,
    required String questionSubject,
    required List<OptionsQuestionModel> options,
  }) : super(
          id: id,
          questionNumber: questionNumber,
          surveyId: surveyId,
          section: section,
          inputType: inputType,
          questionName: questionName,
          questionSubject: questionSubject,
          options: options,
        );

  factory DetailQuestionsModel.fromJson(Map<String, dynamic> jsonMap) {
    return DetailQuestionsModel(
      id: jsonMap['id'],
      questionNumber: jsonMap['question_number'],
      surveyId: jsonMap['survey_id'],
      section: jsonMap['section'],
      inputType: jsonMap['input_type'],
      questionName: jsonMap['question_name'],
      questionSubject: jsonMap['question_subject'],
      options: List<OptionsQuestionModel>.from(
          jsonMap['options'].map((x) => OptionsQuestionModel.fromJson(x))),
    );
  }
}

class OptionsQuestionModel extends OptionsQuestionEntity {
  const OptionsQuestionModel({
    required String id,
    required String questionId,
    required String optionName,
    required int value,
    required String color,
  }) : super(
            id: id,
            questionId: questionId,
            optionName: optionName,
            value: value,
            color: color);

  factory OptionsQuestionModel.fromJson(Map<String, dynamic> jsonMap) {
    return OptionsQuestionModel(
      id: jsonMap['id'],
      questionId: jsonMap['question_id'],
      optionName: jsonMap['option_name'],
      value: jsonMap['value'],
      color: jsonMap['color'],
    );
  }
}
