import 'package:app/application/bloc/alarms/active_alarm_bloc.dart';
import 'package:app/application/bloc/user/user_bloc.dart';
import 'package:app/application/cubit/login/login_cubit.dart';
import 'package:app/application/cubit/pooling/pooling_cubit.dart';
import 'package:app/domain/user/entity/user.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/jay_bottom_navigation_bar.dart';
import 'package:app/presentation/components/jay_drawer.dart';
import 'package:app/presentation/components/jay_progress_indicator.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:app/presentation/pages/event_page.dart';
import 'package:app/presentation/pages/widgets/app_bar_alarm.dart';
import 'package:app/presentation/pages/widgets/event_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../application/cubit/logout/logout_cubit.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    context.read<PoolingCubit>().close();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            create: (final context) => UserBloc()..add(UserStarted()),
          ),
          BlocProvider(
            create: (final context) {
              final bloc = ActiveAlarmBloc();
              bloc.add(
                ActiveAlarmStarted(
                  enableLiveUpdate: true,
                ),
              );
              return bloc;
            },
          ),
          BlocProvider(
            create: (final context) => PoolingCubit()..start(),
          ),
        ],
        child: BlocBuilder<UserBloc, UserState>(
          builder: (final context, final userState) {
            if (userState is UserLoadFailure) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.error,
                                size: 96,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              const Text(
                                'Uživatel nebyl nalezen',
                                style: TextStyle(fontSize: 24),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              const Text(
                                'Zkuste akci opakovat nebo proveďte novou registraci.',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<UserBloc>(context,
                                            listen: false)
                                        .add(UserStarted());
                                  },
                                  child: const Text('Opakovat')),
                              const SizedBox(
                                height: 16,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    context.read<LoginCubit>().logout();
                                  },
                                  child: const Text('Nová registrace'))
                            ],
                          ))
                    ],
                  ),
                ),
              );
            }
            if (userState is UserLoadInProgress) {
              return Material(
                child: const JayProgressIndicator(
                    text: 'Stahuji informace o uživateli'),
              );
            }
            if (userState is UserLoadSuccess) {
              return BlocListener<PoolingCubit, PoolingState>(
                listener: (BuildContext context, PoolingState state) {
                  if (state is PoolingFetched) {
                    context
                        .read<ActiveAlarmBloc>()
                        .add(ActiveAlarmSilentRefresh());
                  }
                },
                child: Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 80,
                    backgroundColor: JayColors.primary,
                    title: BlocBuilder<ActiveAlarmBloc, ActiveAlarmState>(
                      builder: (final context, final state) {
                        if (state is ActiveAlarmLoadSuccess) {
                          if (state.alarms.isEmpty) {
                            return const Text('Žádný aktivní poplach');
                          } else {
                            return AppBarAlarm(
                              eventDetail: state.alarms[_currentPageIndex],
                            );
                          }
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    //bottom: TextToSpeechControlPanel(),
                  ),
                  body: BlocBuilder<ActiveAlarmBloc, ActiveAlarmState>(
                    builder: (final context, final state) {
                      if (state is ActiveAlarmLoadSuccess) {
                        if (state.alarms.isNotEmpty) {
                          return PageView(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: state.alarms
                                .map<Widget>(
                                  (a) => EventPage(
                                    memberId: userState.memberId,
                                    eventId: a.eventId,
                                    alarmDto: a,
                                  ),
                                )
                                .toList(),
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/sleeping.svg',
                                width: 128,
                              ),
                              const SizedBox(height: 16),
                              const EventHeader(
                                title: 'Nic se neděje',
                              ),
                              const Padding(
                                padding: EdgeInsets.all(16),
                                child: JayWhiteText(
                                  'V tuto chvíli není pro tvoji jednotku zvolán žádný poplach.',
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10),
                              /*
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      context.pushNamed(AppRoutes.eventHistory.name);
                    },
                    child: Text(AppLocalizations.of(context)!.history),
                  ),
                ),*/
                            ],
                          );
                        }
                      }
                      if (state is ActiveAlarmLoadInProgress) {
                        return const JayProgressIndicator(
                            text: 'Stahuji aktuální poplach');
                      }
                      if (state is ActiveAlarmFailure) {
                        return const Center(
                          child: JayWhiteText(
                            'Zkontrolujte připojení',
                            fontSize: 24,
                          ),
                        );
                      }
                      return const JayProgressIndicator(
                          text: 'Stahuji aktuální poplach');
                    },
                  ),
                  bottomNavigationBar:
                      BlocBuilder<ActiveAlarmBloc, ActiveAlarmState>(
                    builder: (final context, final state) {
                      if (state is ActiveAlarmLoadSuccess &&
                          state.alarms.isNotEmpty) {
                        return JayBottomNavigationBar(
                          alarms: state.alarms,
                          currentPageIndex: _currentPageIndex,
                          onTap: _onPageTap,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  drawer: JayDrawer(
                      name: userState.fullName, memberId: userState.memberId),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      );

  void _onPageTap(final int index) {
    // Place where we can add transition animations
    setState(() {
      _currentPageIndex = index;
      _pageController.jumpToPage(
        index,
      );
    });
  }
}
