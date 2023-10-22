


import 'package:equatable/equatable.dart';
import 'package:synapsis_survei/domain/entities/all_survei_entity.dart';

abstract class SurveiState extends Equatable{
  const SurveiState();

  @override
  List<Object?> get props => [];
}

class SurveiEmpty extends SurveiState {}

class SurveiLoading extends SurveiState {}

class SurveiLoaded extends SurveiState {
  final AllSurveiEntity result;

  const SurveiLoaded({required this.result});

  @override
  List<Object?> get props => [result];
}

class SurveiLoadFailure extends SurveiState {
  final String message;

  const SurveiLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class GetCookie extends SurveiState {
  final String cookie;

  const GetCookie(this.cookie);

  @override
  List<Object?> get props => [cookie];
}

class GetCookieFailed extends SurveiState {}

class CookieDeleted extends SurveiState {}

class CookieDeleteFailed extends SurveiState {}



