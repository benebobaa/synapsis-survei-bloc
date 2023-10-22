import 'package:flutter/material.dart';
import 'package:synapsis_survei/core/common/pages/under_construction_page.dart';
import 'package:synapsis_survei/presentation/pages/login_page.dart';
import 'package:synapsis_survei/presentation/pages/detail_survei_page.dart';
import 'package:synapsis_survei/presentation/pages/survei_page.dart';
import 'package:synapsis_survei/presentation/pages/weather_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  dynamic args = settings.arguments;
  switch (settings.name) {
    // case OnBoardingScreen.routeName:
    //   return _pageBuilder((_) => const OnBoardingScreen(), settings: settings);
    //weather
    case WeatherPage.routeName:
      return _pageBuilder((_) => const WeatherPage(), settings: settings);

    //survei
    case SurveiPage.routeName:
      return _pageBuilder((_) => const SurveiPage(), settings: settings);

    //login
    case LoginPage.routeName:
      return _pageBuilder((_) => const LoginPage(), settings: settings);

    //survei answer
    case DetailSurveiPage.routeName:
      return _pageBuilder(
          (_) => DetailSurveiPage(
                surveiId: args,
              ),
          settings: settings);

    default:
      return _pageBuilder(
        (_) => const UnderConstructionPage(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
