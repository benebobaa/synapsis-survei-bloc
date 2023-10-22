import 'package:synapsis_survei/domain/entities/login_success_entity.dart';

class LoginSuccessModel extends LoginSuccessEntity {
  const LoginSuccessModel(
      {required int code,
      required bool status,
      required String message,
      required DataLoginModel data})
      : super(code: code, status: status, message: message, data: data);

  factory LoginSuccessModel.fromJson(Map<String, dynamic> jsonMap) {
    return LoginSuccessModel(
      code: jsonMap['code'],
      status: jsonMap['status'],
      message: jsonMap['message'],
      data: DataLoginModel.fromJson(jsonMap['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'message': message,
        'data': data.toJson(),
      };

  LoginSuccessEntity toEntity() => LoginSuccessEntity(
        code: code,
        status: status,
        message: message,
        data: data.toEntity(),
      );
}

class DataLoginModel extends DataLoginEntity {
  const DataLoginModel(
      {required int occupationLevel, required String occupationName})
      : super(occupationLevel: occupationLevel, occupationName: occupationName);

  factory DataLoginModel.fromJson(Map<String, dynamic> jsonMap) {
    return DataLoginModel(
      occupationLevel: jsonMap['occupation_level'],
      occupationName: jsonMap['occupation_name'],
    );
  }

  
}
