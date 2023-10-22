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
  const OnCheckCookie();

  @override
  List<Object?> get props => [];
}

class OnDeleteCookie extends SurveiEvent {
  const OnDeleteCookie();

  @override
  List<Object?> get props => [];
}

class OnCountDown extends SurveiEvent {
  const OnCountDown();

  @override
  List<Object?> get props => [];
}
