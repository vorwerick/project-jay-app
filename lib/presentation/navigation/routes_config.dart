import 'package:app/application/commands/has_active_alarm_async_cmd.dart';
import 'package:app/domain/repositories/alarm_repository.dart';
import 'package:app/presentation/pages/event_detail_page.dart';
import 'package:app/presentation/pages/event_history_page.dart';
import 'package:app/presentation/pages/home_page.dart';
import 'package:app/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';

final class RoutesConfig {
  RoutesConfig._();

  static Future<String> _getInitialRoute() async {
    final repository = GetIt.I.get<AlarmRepository>();

    final hasActiveAlarm = await HasActiveAlarmAsyncCommand(repository).execute();

    if (hasActiveAlarm) {
      return AppRoutes.home.path;
    }
    return AppRoutes.eventHistory.path;
  }

  static Future<GoRouter> create() async => GoRouter(
        initialLocation: await _getInitialRoute(),
        routes: [
          GoRoute(
            path: AppRoutes.login.path,
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            name: AppRoutes.home.name,
            path: AppRoutes.home.path,
            pageBuilder: (context, state) => _createTransition(state.pageKey, const HomePage()),
          ),
          GoRoute(
            name: AppRoutes.eventHistory.name,
            path: AppRoutes.eventHistory.path,
            pageBuilder: (context, state) => _createTransition(state.pageKey, const EventHistoryPage()),
            routes: [
              GoRoute(
                name: AppRoutes.eventDetail.name,
                path: '${AppRoutes.eventDetail.name}/:eventId',
                pageBuilder: (context, state) => _createTransition(
                  state.pageKey,
                  EventDetailPage(
                    eventId: int.parse(state.pathParameters['eventId']!),
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  static CustomTransitionPage _createTransition(final LocalKey? key, final Widget page) => CustomTransitionPage(
        key: key,
        child: page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        ),
      );
}
