import 'package:synapsis_survei/domain/entities/all_survei_entity.dart';

class AllSurveiModel extends AllSurveiEntity {
  const AllSurveiModel({
    required int code,
    required bool status,
    required String message,
    required int totalAllData,
    required List<DataAllSurveiModel> data,
  }) : super(
          code: code,
          status: status,
          message: message,
          totalAllData: totalAllData,
          data: data,
        );

  factory AllSurveiModel.fromJson(Map<String, dynamic> jsonMap) {
    return AllSurveiModel(
      code: jsonMap['code'],
      status: jsonMap['status'],
      message: jsonMap['message'],
      totalAllData: jsonMap['total_all_data'],
      data: List<DataAllSurveiModel>.from(
          jsonMap['data'].map((x) => DataAllSurveiModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'message': message,
        'total_all_data': totalAllData,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };

  AllSurveiEntity toEntity() => AllSurveiEntity(
        code: code,
        status: status,
        message: message,
        totalAllData: totalAllData,
        data: List<DataAllSurveiEntity>.from(data.map((x) => x.toEntity())),
      );
}

class DataAllSurveiModel extends DataAllSurveiEntity {
  const DataAllSurveiModel({
    required String id,
    required String surveyName,
    required int status,
    required int totalRespondent,
    required String createdAt,
    required String updatedAt,
    required List<QuestionsModel> questions,
  }) : super(
          id: id,
          surveyName: surveyName,
          status: status,
          totalRespondent: totalRespondent,
          createdAt: createdAt,
          updatedAt: updatedAt,
          questions: questions,
        );

  factory DataAllSurveiModel.fromJson(Map<String, dynamic> jsonMap) {
    return DataAllSurveiModel(
      id: jsonMap['id'],
      surveyName: jsonMap['survey_name'],
      status: jsonMap['status'],
      totalRespondent: jsonMap['total_respondent'],
      createdAt: jsonMap['created_at'],
      updatedAt: jsonMap['updated_at'],
      questions: List<QuestionsModel>.from(
          jsonMap['questions'].map((x) => QuestionsModel.fromJson(x))),
    );
  }
}

class QuestionsModel extends QuestionsEntity {
  const QuestionsModel(
      {required String questionName,
      required String inputType,
      required String questionId})
      : super(
          questionName: questionName,
          inputType: inputType,
          questionId: questionId,
        );

  factory QuestionsModel.fromJson(Map<String, dynamic> jsonMap) {
    return QuestionsModel(
      questionName: jsonMap['question_name'],
      inputType: jsonMap['input_type'],
      questionId: jsonMap['question_id'],
    );
  }
}
