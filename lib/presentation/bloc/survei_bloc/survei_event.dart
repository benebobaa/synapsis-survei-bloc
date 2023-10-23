import 'package:equatable/equatable.dart';

abstract class SurveiEvent extends Equatable {
  const SurveiEvent();

  @override
  List<Object?> get props => [];
}

class OnGetAllSurvei extends SurveiEvent {
  const OnGetAllSurvei();

  @override
  List<Object?> get props => [];
}

class OnCheckCookie extends SurveiEvent {
  final String key;
  const OnCheckCookie(this.key);

  @override
  List<Object?> get props => [key];
}

class OnCountDown extends SurveiEvent {
  const OnCountDown();

  @override
  List<Object?> get props => [];
}
