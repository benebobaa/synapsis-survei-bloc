



import 'package:equatable/equatable.dart';

class LoginFailedEntity extends Equatable {
  final int code;
  final bool status;
  final String message;
  final String data;

  const LoginFailedEntity(
      {required this.code,
      required this.status,
      required this.message,
      required this.data});

  @override
  List<Object?> get props => [code, status, message, data];
}