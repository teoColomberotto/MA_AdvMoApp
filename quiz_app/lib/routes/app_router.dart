import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../features/home/views/home_screen.dart';
import '../features/splash/views/splash_screen.dart';
import '../features/leaderboard/views/leaderboard_screen.dart';
import '../features/quizz/views/quiz_screen.dart';
import '../features/quizz/views/quiz_recap_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(path: '/home', page: HomeRoute.page, initial: false),
        AutoRoute(path: '/quiz', page: QuizRoute.page, initial: false),
        AutoRoute(
            path: '/quiz/recap', page: QuizRecapRoute.page, initial: false),
        AutoRoute(
            path: '/leaderboard', page: LeaderboardRoute.page, initial: false),
        AutoRoute(path: '/', page: SplashRoute.page, initial: true),
      ];
}
