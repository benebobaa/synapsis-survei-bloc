import 'package:equatable/equatable.dart';

class LoginSuccessEntity extends Equatable {
  final int code;
  final bool status;
  final String message;
  final DataLoginEntity data;

  const LoginSuccessEntity(
      {required this.code,
      required this.status,
      required this.message,
      required this.data});

  @override
  List<Object?> get props => [code, status, message, data];
}

class DataLoginEntity extends Equatable {
  final int occupationLevel;
  final String occupationName;

  const DataLoginEntity(
      {required this.occupationLevel, required this.occupationName});

  Map<String, dynamic> toJson() => {
        'occupation_level': occupationLevel,
        'occupation_name': occupationName,
      };

  DataLoginEntity toEntity() => DataLoginEntity(
        occupationLevel: occupationLevel,
        occupationName: occupationName,
      );

  @override
  List<Object?> get props => [occupationLevel, occupationName];
}
