import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todolistapp/features/presentation/authentication/login_screen.dart';
import 'package:todolistapp/features/presentation/authentication/register_screen.dart';
import 'package:todolistapp/features/presentation/main/main_screen.dart';
import 'package:todolistapp/features/presentation/onboarding/onboarding_screen.dart';
import 'package:todolistapp/features/presentation/splash/splash_screen.dart';
import 'package:todolistapp/features/presentation/start/start_screen.dart';

part 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: OnBoardingRoute.page),
        AutoRoute(page: StartRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: MainRoute.page),
      ];
}
