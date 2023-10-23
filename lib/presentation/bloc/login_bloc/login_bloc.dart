import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survei/core/constants/api_urls.dart';
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
      /// TODO: NOTE
      /// Only save email, because saving password is risky for user privacy
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

    on<OnLoginFingerprint>((event, emit) async {
      emit(LoginLoading());
      final result = await _loginUsecase.loginFingerprint(ApiUrls.cookieKey);
      await Future.delayed(const Duration(milliseconds: 500));
      result.fold((failure) {
        log(failure.message);
        emit(LoginFailure(failure.message));
      }, (data) async {
        emit(LoginFingerprintMatch(data));
      });
    });

    on<OnCheckToken>((event, emit) async {
      emit(LoginLoading());
      final result = await _loginUsecase.checkTokenExpired(event.token);

      result.fold((failure) {
        emit(TokenExpired(failure.message));
      }, (data) async {
        emit(LoginFingerprintSuccess());
      });
    });

    on<OnDeleteCookie>((event, emit) async {
      final result = await _loginUsecase.deleteCookie(ApiUrls.cookieKey);
      result.fold((failure) {
        emit(LoginFailure(failure.message));
      }, (data) async {
        emit(LoginInitial());
      });
    });
  }
}
