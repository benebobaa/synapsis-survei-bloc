import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survei/domain/entities/detail_survei_entity.dart';
import 'package:synapsis_survei/domain/entities/survei_answer_entity.dart';
import 'package:synapsis_survei/domain/usecases/survei_usecase.dart';
import 'package:synapsis_survei/presentation/bloc/survei_detail_bloc/detail_survei_event.dart';
import 'package:synapsis_survei/presentation/bloc/survei_detail_bloc/detail_survei_state.dart';

class DetailSurveiBloc extends Bloc<DetailSurveiEvent, DetailSurveiState> {
  final SurveiUsecase _surveiUsecase;
  int currentQuestion = 0;
  late DetailSurveiEntity detailSurveiEntity;
  late SurveiAnswerEntity surveiAnswerEntity;
  late String surveiId;
  late List<DataSurveiAnswerEntity> dataSurveiAnswerEntity;

  List<DataSurveiAnswerEntity> tempData = [];

  DetailSurveiBloc(this._surveiUsecase)
      : super(const DetailSurveiInitial(
            0, SurveiAnswerEntity(surveiId: '', data: []))) {
    on<OnGetDetailSurvei>((event, emit) async {
      emit(DetailSurveiLoading());
      final result = await _surveiUsecase.detailSurvei(event.surveiId);

      result.fold(
        (failure) {
          emit(DetailSurveiLoadFailure(failure.message));
        },
        (data) {
          detailSurveiEntity = data;
          for (var i in data.data.questions) {
            tempData.add(DataSurveiAnswerEntity(
                questionId: i.id, answer: '', value: 9998));
          }
          surveiAnswerEntity =
              SurveiAnswerEntity(surveiId: data.data.id, data: tempData);
          emit(DetailSurveiLoaded(data, 0, surveiAnswerEntity));
        },
      );
    });

    on<OnNextQuestion>((event, emit) {
      currentQuestion = currentQuestion + 1;
      emit(DetailSurveiLoaded(
          detailSurveiEntity, currentQuestion, surveiAnswerEntity));
    });

    on<OnBackQuestion>((event, emit) {
      currentQuestion = currentQuestion - 1;
      emit(DetailSurveiLoaded(
          detailSurveiEntity, currentQuestion, surveiAnswerEntity));
    });

    on<OnSubmitSurvei>((event, emit) {
      currentQuestion = 0;
      tempData.clear();
      surveiAnswerEntity = SurveiAnswerEntity(surveiId: '', data: tempData);
      emit(DetailSurveiInitial(currentQuestion, surveiAnswerEntity));
    });

    on<OnAnswerQuestion>((event, emit) {
      surveiAnswerEntity.data
          .firstWhere(
            (element) => element.questionId == event.data.questionId,
          )
          .answer = event.data.answer;
      surveiAnswerEntity.data
          .firstWhere(
            (element) => element.questionId == event.data.questionId,
          )
          .value = event.data.value;

      emit(DetailSurveiLoaded(
          detailSurveiEntity, currentQuestion, surveiAnswerEntity));
    });

    on<OnSelectFromPicker>((event, emit) {
      currentQuestion = event.currentQuestion;
      emit(DetailSurveiLoaded(
          detailSurveiEntity, currentQuestion, surveiAnswerEntity));
    });
  }
}
