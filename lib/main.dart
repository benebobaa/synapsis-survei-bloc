// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:synapsis_survei/core/services/router.dart';
import 'package:synapsis_survei/injection_container.dart';
import 'package:synapsis_survei/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:synapsis_survei/presentation/bloc/survei_bloc/survei_bloc.dart';
import 'package:synapsis_survei/presentation/bloc/survei_detail_bloc/detail_survei_bloc.dart';
import 'package:synapsis_survei/presentation/bloc/weather_bloc.dart';

void main(List<String> isDebug) async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.setup();
  runApp(
    MyApp(
      isDebug: isDebug.contains('--debug') ? true : false,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.isDebug,
  }) : super(key: key);

  final bool isDebug;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<WeatherBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<LoginBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<SurveiBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<DetailSurveiBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: isDebug,
        title: 'Flutter Demo',
        theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        onGenerateRoute: generateRoute,
        // initialRoute: SurveiPage.routeName,
        // home: const WeatherPage(),
      ),
    );
  }
}
