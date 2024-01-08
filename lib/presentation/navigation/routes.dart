import 'package:app/presentation/pages/event_history_page.dart';
import 'package:app/presentation/pages/home_page.dart';
import 'package:app/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes {
  login('login'),
  home('home'),
  eventHistory('event-history');

  final String name;
  String get path => '/$name';

  const AppRoutes(this.name);
}

final class Routes {
  Routes._();

  static GoRouter create() {
    return GoRouter(
      initialLocation: AppRoutes.home.path,
      routes: [
        GoRoute(
          path: AppRoutes.login.path,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
            name: AppRoutes.home.name,
            path: AppRoutes.home.path,
            pageBuilder: (context, state) => _createTransition(state.pageKey, const HomePage()),
            routes: [
              GoRoute(
                name: AppRoutes.eventHistory.name,
                path: AppRoutes.eventHistory.name,
                pageBuilder: (context, state) => _createTransition(state.pageKey, const EventHistoryPage()),
              )
            ]),
      ],
    );
  }

  static CustomTransitionPage _createTransition(final LocalKey? key, final Widget page) {
    return CustomTransitionPage(
      key: key,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  }
}
