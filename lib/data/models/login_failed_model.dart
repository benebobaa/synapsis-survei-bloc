import 'package:synapsis_survei/domain/entities/login_failed_entity.dart';

class LoginFailedModel extends LoginFailedEntity {
  const LoginFailedModel(
      {required int code,
      required bool status,
      required String message,
      required String data})
      : super(code: code, status: status, message: message, data: data);

  factory LoginFailedModel.fromJson(Map<String, dynamic> jsonMap) {
    return LoginFailedModel(
      code: jsonMap['code'],
      status: jsonMap['status'],
      message: jsonMap['message'],
      data: jsonMap['data'],
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'message': message,
        'data': data,
      };

  LoginFailedEntity toEntity() => LoginFailedEntity(
        code: code,
        status: status,
        message: message,
        data: data,
      );
}
