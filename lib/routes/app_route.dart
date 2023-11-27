import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todolistapp/features/data/models/todo_model.dart';
import '../features/presentation/authentication/login_screen.dart';
import '../features/presentation/authentication/register_screen.dart';
import '../features/presentation/main/main_screen.dart';
import '../features/presentation/onboarding/onboarding_screen.dart';
import '../features/presentation/settings/settings_screen.dart';
import '../features/presentation/splash/splash_screen.dart';
import '../features/presentation/start/start_screen.dart';
import '../features/presentation/task/task_screen.dart';

part 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page),
        AutoRoute(page: OnBoardingRoute.page),
        AutoRoute(page: StartRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: MainRoute.page, initial: true),
        AutoRoute(page: TaskRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ];
}
