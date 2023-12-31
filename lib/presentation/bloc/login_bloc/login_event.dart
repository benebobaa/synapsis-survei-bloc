import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class OnLogin extends LoginEvent {
  final String email;
  final String password;

  const OnLogin({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class OnEmailSaved extends LoginEvent {
  final String email;
  final String key;

  const OnEmailSaved({required this.email, required this.key});

  @override
  List<Object?> get props => [email];
}

class OnGetEmailCache extends LoginEvent {
  final String key;

  const OnGetEmailCache({required this.key});

  @override
  List<Object?> get props => [key];
}


class OnLoginFingerprint extends LoginEvent{
  
}

class OnCheckToken extends LoginEvent{
  final String token;

  const OnCheckToken(this.token);


  @override

  List<Object?> get props => [token];
}

class OnDeleteCookie extends LoginEvent {
  const OnDeleteCookie();

  @override
  List<Object?> get props => [];
}