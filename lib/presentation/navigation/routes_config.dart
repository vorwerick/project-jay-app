import 'dart:developer';

import 'package:app/application/commands/has_active_event_async_cmd.dart';
import 'package:app/application/commands/is_registered_async_cmd.dart';
import 'package:app/application/services/event_service.dart';
import 'package:app/domain/event/repository/events_storage_repository.dart';
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
  ValueNotifier<RoutingConfig>? _myRoutingConfig;

  final EventService _eventService;

  RoutesConfig(this._eventService) {
    _eventService.stream.listen(_onEventChange);
  }

  Future<GoRouter> create() async {
    final config = await _createConfig();

    _myRoutingConfig = ValueNotifier(config);

    return GoRouter.routingConfig(
      initialLocation: await _getInitialRoute(),
      routingConfig: _myRoutingConfig!,
    );
  }

  void _onEventChange(final bool isActive) {
    log('Event is active: $isActive', name: 'RoutesConfig');
    updateRouteConfig();
  }

  Future<void> updateRouteConfig() async {
    final config = await _createConfig();
    _myRoutingConfig?.value = config;
  }

  Future<String> _getInitialRoute() async {
    final repository = GetIt.I.get<SettingRepository>();

    final isRegistered = await IsRegisteredAsync(repository).execute();

    if (isRegistered) {
      return AppRoutes.home.path;
    }
    return AppRoutes.deviceRegistration.path;
  }

  Future<Widget> _getDefaultHomeScreen() async {
    final repository = GetIt.I.get<EventsStorageRepository>();

    final hasActiveEvent = await HasActiveEventAsync(repository).execute();

    if (hasActiveEvent) {
      return const HomePage();
    }

    return const HomeInactivePage();
  }

  Future<RoutingConfig> _createConfig() async {
    final home = await _getDefaultHomeScreen();

    return RoutingConfig(
      routes: [
        GoRoute(
          name: AppRoutes.home.name,
          path: AppRoutes.home.path,
          pageBuilder: (final context, final state) => _createTransition(state.pageKey, home),
        ),
        GoRoute(
          path: AppRoutes.deviceRegistration.path,
          builder: (final context, final state) => const RegisterDevicePage(),
        ),
        GoRoute(
          path: AppRoutes.login.path,
          builder: (final context, final state) => const LoginPage(),
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
  }

  CustomTransitionPage _createTransition(final LocalKey? key, final Widget page) => CustomTransitionPage(
        key: key,
        child: page,
        transitionsBuilder: (final context, final animation, final secondaryAnimation, final child) => FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        ),
      );
}
