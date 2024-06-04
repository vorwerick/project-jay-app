import 'package:app/application/bloc/alarms/alert_bloc.dart';
import 'package:app/application/bloc/settings/version/app_version_bloc.dart';
import 'package:app/application/bloc/user/user_bloc.dart';
import 'package:app/application/cubit/logout/logout_cubit.dart';
import 'package:app/configuration/navigation/app_routes.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/jay_white_text.dart';
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
          BlocProvider<LogoutCubit>(create: (final context) => LogoutCubit()),
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
                        if (state is UserLoadSuccess) {
                          return Center(
                            child: JayWhiteText(
                              state.fullName,
                            ),
                          );
                        }
                        if (state is UserLoadFailure) {
                          return Center(
                            child: JayWhiteText(
                              AppLocalizations.of(context)!.checkConnection,
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
                  Builder(
                    builder: (final context) => BlocListener<LogoutCubit, LogoutState>(
                      listener: (final context, final state) {
                        if (state is LogoutSuccess) {
                          context.pop();
                          context.go(AppRoutes.deviceRegistration.path);
                        }
                      },
                      child: ListTile(
                        title: Text(AppLocalizations.of(context)!.logout),
                        onTap: () {
                          context.read<LogoutCubit>().logout();
                        },
                      ),
                    ),
                  ),
                  BlocBuilder<AppVersionBloc, AppVersionState>(
                    builder: (final context, final state) {
                      if (state is AppVersionLoadSuccess) {
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
