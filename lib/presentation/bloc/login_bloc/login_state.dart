import 'package:equatable/equatable.dart';
import 'package:synapsis_survei/domain/entities/login_success_entity.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginSuccessEntity result;

  const LoginSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class EmailSaved extends LoginState {
  final String email;

  const EmailSaved(this.email);

  @override
  List<Object?> get props => [email];
}

class EmailSavedError extends LoginState {
  final String message;

  const EmailSavedError(this.message);

  @override
  List<Object?> get props => [message];
}


class EmailCacheLoaded extends LoginState {
  final String email;

  const EmailCacheLoaded(this.email);

  @override
  List<Object?> get props => [email];
}

class EmailCacheError extends LoginState {
  final String message;

  const EmailCacheError(this.message);

  @override
  List<Object?> get props => [message];
}

class LoginFingerprintSuccess extends LoginState{
  
}
