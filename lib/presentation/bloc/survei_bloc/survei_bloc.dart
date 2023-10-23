import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survei/core/constants/api_urls.dart';
import 'package:synapsis_survei/domain/usecases/survei_usecase.dart';
import 'package:synapsis_survei/presentation/bloc/survei_bloc/survei_event.dart';
import 'package:synapsis_survei/presentation/bloc/survei_bloc/survei_state.dart';

class SurveiBloc extends Bloc<SurveiEvent, SurveiState> {
  final SurveiUsecase _surveiUsecase;

  SurveiBloc(this._surveiUsecase) : super(SurveiEmpty()) {
    on<OnGetAllSurvei>((event, emit) async {
      emit(SurveiLoading());
      final result = await _surveiUsecase.allSurvei(ApiUrls.cookieKey);

      result.fold(
        (failure) {
          emit(SurveiLoadFailure(failure.message));
        },
        (data) {
          emit(SurveiLoaded(result: data));
        },
      );
    });

    on<OnCheckCookie>((event, emit) async {
      final result = await _surveiUsecase.getCookie(ApiUrls.cookieKey);

      result.fold((failure) {
        emit(GetCookieFailed());
      }, (data) {
        emit(GetCookie(data));
      });
    });

   
  }
}
