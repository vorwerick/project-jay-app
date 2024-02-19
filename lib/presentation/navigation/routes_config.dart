import 'package:app/application/commands/is_registered_async_cmd.dart';
import 'package:app/domain/settings/repository/setting_repository.dart';
import 'package:app/presentation/pages/event_detail_page.dart';
import 'package:app/presentation/pages/event_history_page.dart';
import 'package:app/presentation/pages/home_inactive_page.dart';
import 'package:app/presentation/pages/home_page.dart';
import 'package:app/presentation/pages/login_page.dart';
import 'package:app/presentation/pages/pdf_page.dart';
import 'package:app/presentation/pages/register_device_page.dart';
import 'package:app/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';

final class RoutesConfig {
  RoutesConfig._();

  static Future<String> _getInitialRoute() async {
    final repository = GetIt.I.get<SettingRepository>();

    final isRegistered = await IsRegisteredAsync(repository).execute();

    if (isRegistered) {
      return AppRoutes.home.path;
    }
    return AppRoutes.deviceRegistration.path;
  }

  static Future<GoRouter> create() async => GoRouter(
        initialLocation: await _getInitialRoute(),
        routes: [
          GoRoute(
            path: AppRoutes.deviceRegistration.path,
            builder: (final context, final state) => const RegisterDevicePage(),
          ),
          GoRoute(
            path: AppRoutes.login.path,
            builder: (final context, final state) => const LoginPage(),
          ),
          GoRoute(
            name: AppRoutes.home.name,
            path: AppRoutes.home.path,
            pageBuilder: (final context, final state) => _createTransition(state.pageKey, const HomePage()),
          ),
          GoRoute(
            name: AppRoutes.homeInactive.name,
            path: AppRoutes.homeInactive.path,
            pageBuilder: (final context, final state) => _createTransition(state.pageKey, const HomeInactivePage()),
          ),
          GoRoute(
            name: AppRoutes.eventHistory.name,
            path: AppRoutes.eventHistory.path,
            pageBuilder: (final context, final state) => _createTransition(state.pageKey, const EventHistoryPage()),
            routes: [
              GoRoute(
                name: AppRoutes.eventDetail.name,
                path: '${AppRoutes.eventDetail.name}/:eventId',
                pageBuilder: (final context, final state) => _createTransition(
                  state.pageKey,
                  EventDetailPage(
                    eventId: int.parse(state.pathParameters['eventId']!),
                  ),
                ),
              ),
            ],
          ),
          GoRoute(
            name: AppRoutes.pdf.name,
            path: '${AppRoutes.pdf.path}/:filePath',
            pageBuilder: (final context, final state) => _createTransition(
              state.pageKey,
              PdfPage(
                path: state.pathParameters['filePath']!,
              ),
            ),
          ),
          GoRoute(
            name: AppRoutes.settings.name,
            path: AppRoutes.settings.path,
            pageBuilder: (final context, final state) => _createTransition(
              state.pageKey,
              const SettingsPage(),
            ),
          ),
        ],
      );

  static CustomTransitionPage _createTransition(final LocalKey? key, final Widget page) => CustomTransitionPage(
        key: key,
        child: page,
        transitionsBuilder: (final context, final animation, final secondaryAnimation, final child) => FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        ),
      );
}

class test extends RouteObserver {}
