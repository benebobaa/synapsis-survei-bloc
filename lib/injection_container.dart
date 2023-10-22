import 'package:shared_preferences/shared_preferences.dart';
import 'package:synapsis_survei/data/data_sources/local_data_sources/login_local_data_source.dart';
import 'package:synapsis_survei/data/data_sources/local_data_sources/survei_local_darta_source.dart';
import 'package:synapsis_survei/data/data_sources/remote_data_source.dart';
import 'package:synapsis_survei/data/data_sources/remote_data_sources/login_remote_data_source.dart';
import 'package:synapsis_survei/data/data_sources/remote_data_sources/survei_remote_data_source.dart';
import 'package:synapsis_survei/data/repositories/login_repository_impl.dart';
import 'package:synapsis_survei/data/repositories/survei_repository_impl.dart';
import 'package:synapsis_survei/data/repositories/weather_repository_impl.dart';
import 'package:synapsis_survei/domain/repositories/login_repository.dart';
import 'package:synapsis_survei/domain/repositories/survei_repository.dart';
import 'package:synapsis_survei/domain/repositories/weather_repository.dart';
import 'package:synapsis_survei/domain/usecases/get_current_weather.dart';
import 'package:synapsis_survei/domain/usecases/login_usecase.dart';
import 'package:synapsis_survei/domain/usecases/survei_usecase.dart';
import 'package:synapsis_survei/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:synapsis_survei/presentation/bloc/survei_bloc/survei_bloc.dart';
import 'package:synapsis_survei/presentation/bloc/survei_detail_bloc/detail_survei_bloc.dart';
import 'package:synapsis_survei/presentation/bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

class ServiceLocator {
  static Future<void> setup() async {
    //bloc
    locator.registerFactory(() => WeatherBloc(locator()));
    locator.registerFactory(() => LoginBloc(locator()));
    locator.registerFactory(() => SurveiBloc(locator()));
    locator.registerFactory(() => DetailSurveiBloc(locator()));

    //usecase
    locator.registerLazySingleton(() => GetCurrentWeatherUsecase(locator()));
    locator.registerLazySingleton(() => LoginUsecase(locator()));
    locator.registerLazySingleton(() => SurveiUsecase(locator()));

    // repository
    locator.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(weatherRemoteDataSource: locator()),
    );
    locator.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(
          loginRemoteDataSource: locator(), loginLocalDataSource: locator()),
    );
    locator.registerLazySingleton<SurveiRepository>(
      () => SurveiRepositoryImpl(
          surveiRemoteDataSource: locator(), surveiLocalDataSource: locator()),
    );

    //data source
    locator.registerLazySingleton<WeatherRemoteDataSource>(
        () => WeatherRemoteDataSourceImpl(client: locator()));
    locator.registerLazySingleton<LoginRemoteDataSource>(() =>
        LoginRemoteDataSourceImpl(
            client: locator(), sharedPreferences: locator()));
    locator.registerLazySingleton<LoginLocalDataSource>(
        () => LoginLocalDataSourceImpl(sharedPreferences: locator()));
    locator.registerLazySingleton<SurveiRemoteDataSource>(() =>
        SurveiRemoteDataSourceImpl(
            client: locator(), sharedPreferences: locator()));
    locator.registerLazySingleton<SurveiLocalDataSource>(
        () => SurveiLocalDataSourceImpl(sharedPreferences: locator()));

    //http
    locator.registerLazySingleton(() => http.Client());

    //shared preference
    final sharedPreferences = await SharedPreferences.getInstance();
    locator.registerSingleton<SharedPreferences>(sharedPreferences);
  }
}
