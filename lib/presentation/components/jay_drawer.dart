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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// TODO(vojjta): implement params for drawer
class JayDrawer extends StatelessWidget {
  const JayDrawer({super.key});

  @override
  Widget build(final BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<AppVersionBloc>(
              create: (final context) =>
                  AppVersionBloc()..add(AppVersionStarted())),
          BlocProvider<AlertBloc>(
              create: (final context) => AlertBloc()..add(AlertStarted())),
          BlocProvider<UserBloc>(
              create: (final context) => UserBloc()..add(UserStarted())),
          BlocProvider<LogoutCubit>(create: (final context) => LogoutCubit()),
        ],
        child: SafeArea(
          child: Drawer(
            child: Container(
              child: Column(
                children: [
                  DrawerHeader(
                      padding: EdgeInsets.all(0),
                      decoration: const BoxDecoration(
                        color: JayColors.primary,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<UserBloc, UserState>(
                            builder: (final context, final state) {
                              if (state is UserLoadSuccess) {
                                return Container(
                                  margin: EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 24,
                                        child: SvgPicture.asset(
                                          'assets/firefighter-avatar.svg',
                                          semanticsLabel: 'Firefighter avatar',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(),
                                        state.fullName,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              if (state is UserLoadFailure) {
                                return Center(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .checkConnection,
                                  ),
                                );
                              }

                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          BlocBuilder<AlertBloc, AlertState>(
                            builder: (final context, final state) {
                              if (state is CurrentAlertsState) {
                                return state.alerts.isEmpty
                                    ? Container(
                                        margin: EdgeInsets.all(16),
                                        color: JayColors.primary,
                                        child: Text(
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  color: JayColors.secondary,
                                                  fontWeight:
                                                      FontWeight.normal),
                                          'žádný poplach',
                                        ),
                                      )
                                    : Container(
                                        color: JayColors.secondary,
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/megaphone.svg",
                                              color: JayColors.primary,
                                            ),
                                            Text(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                      color: JayColors.primary,
                                                      fontWeight:
                                                          FontWeight.bold),
                                              'poplach!',
                                            ),
                                          ],
                                        ),
                                      );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ],
                      )),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.eventHistory),
                    onTap: () {
                      // close the drawer
                      context.pop();
                      context.push(AppRoutes.eventHistory.path);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.settings),
                    onTap: () {
                      context.pop();
                      context.pushNamed(AppRoutes.settings.name);
                    },
                  ),
                  Builder(
                    builder: (final context) =>
                        BlocListener<LogoutCubit, LogoutState>(
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
                ],
              ),
            ),
          ),
        ),
      );
}
