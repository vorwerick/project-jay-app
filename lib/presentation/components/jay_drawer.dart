import 'package:app/application/bloc/alarms/alert_bloc.dart';
import 'package:app/application/bloc/settings/version/app_version_bloc.dart';
import 'package:app/application/bloc/user/user_bloc.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/navigation/app_routes.dart';
import 'package:app/presentation/pages/widgets/list/drawer_unit_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

// TODO(vojjta): implement params for drawer
class JayDrawer extends StatelessWidget {
  const JayDrawer({super.key});

  @override
  Widget build(final BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<AppVersionBloc>(create: (final context) => AppVersionBloc()..add(AppVersionStarted())),
          BlocProvider<AlertBloc>(create: (final context) => AlertBloc()..add(AlertStarted())),
          BlocProvider<UserBloc>(create: (final context) => UserBloc()..add(UserStarted())),
        ],
        child: SafeArea(
          child: Drawer(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: JayColors.blue,
                    ),
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (final context, final state) {
                        if (state is CurrentUserState) {
                          return Center(
                            child: Text(
                              state.fullName,
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white),
                            ),
                          );
                        }
                        return const SizedBox.expand();
                      },
                    ),
                  ),
                  BlocBuilder<AlertBloc, AlertState>(
                    builder: (final context, final state) {
                      if (state is CurrentAlertsState) {
                        return Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.alerts.length,
                            itemBuilder: (final context, final index) => DrawerUnitItem(
                              unitName: state.alerts[index].unitName,
                              hasAlert: state.alerts[index].hasActiveAlarm,
                              role: state.alerts[index].role,
                            ),
                          ),
                        );
                      }
                      return const Spacer();
                    },
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.eventHistory),
                    onTap: () {
                      // close the drawer
                      context.pop();
                      context.push(AppRoutes.eventHistory.path);
                    },
                  ),
                  const Divider(color: Colors.black),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.settings),
                    onTap: () {
                      context.pop();
                      context.pushNamed(AppRoutes.settings.name);
                    },
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.logout),
                    onTap: () {
                      // TODO(Vojjta): Update the state of the app.
                      context.pop();
                      context.go(AppRoutes.login.path);
                    },
                  ),
                  BlocBuilder<AppVersionBloc, AppVersionState>(
                    builder: (final context, final state) {
                      if (state is LoadedAppVersionState) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5.0, left: 5.0, right: 5.0),
                          child: Row(
                            children: [
                              Text(
                                'App version: ${state.appVersion}',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
