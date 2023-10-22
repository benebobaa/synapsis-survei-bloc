import 'package:synapsis_survei/domain/usecases/get_current_weather.dart';
import 'package:synapsis_survei/presentation/bloc/weather_event.dart';
import 'package:synapsis_survei/presentation/bloc/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUsecase _getCurrentWeatherUsecase;

  WeatherBloc(this._getCurrentWeatherUsecase) : super(WeatherEmpty()) {
    on<OnCityChange>(
      (event, emit) async {
        emit(WeatherLoading());
        final result = await _getCurrentWeatherUsecase.execute(event.cityName);

        result.fold(
          (failure) {
            emit(WeatherLoadFailure(failure.message));
          },
          (data) {
            emit(WeatherLoaded(result: data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
