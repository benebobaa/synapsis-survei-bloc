import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survei/domain/usecases/login_usecase.dart';
import 'package:synapsis_survei/presentation/bloc/login_bloc/login_event.dart';
import 'package:synapsis_survei/presentation/bloc/login_bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase _loginUsecase;
  LoginBloc(this._loginUsecase) : super(LoginInitial()) {
    on<OnLogin>(
      (event, emit) async {
        emit(LoginLoading());
        final result = await _loginUsecase.login(
          event.email,
          event.password,
        );

        log('cek result $result');
        result.fold(
          (failure) async {
            emit(LoginFailure(failure.message));
          },
          (data) {
            emit(LoginSuccess(data));
          },
        );
      },
    );

    on<OnEmailSaved>(
      (event, emit) async {
        final result =
            await _loginUsecase.saveEmailCache(event.key, event.email);
        result.fold(
          (failure) async {
            emit(EmailSavedError(failure.message));
          },
          (data) {
            emit(EmailSaved(event.email));
          },
        );
      },
    );

    on<OnGetEmailCache>(
      (event, emit) async {
        final result = await _loginUsecase.getEmailCache(event.key);
        result.fold(
          (failure) async {
            emit(EmailCacheError(failure.message));
          },
          (data) {
            emit(EmailCacheLoaded(data));
          },
        );
      },
    );
  }
}
