import 'dart:developer';

import 'package:app/application/bloc/alarms/active_alarm_bloc.dart';
import 'package:app/application/bloc/settings/version/settings_bloc.dart';
import 'package:app/application/bloc/user/user_bloc.dart';
import 'package:app/application/cubit/pooling/pooling_cubit.dart';
import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/infrastructure/utils/pending_navigation.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/jay_drawer.dart';
import 'package:app/presentation/components/jay_progress_indicator.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:app/presentation/pages/event_history_list.dart';
import 'package:app/presentation/pages/event_page.dart';
import 'package:app/presentation/pages/user_not_found_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class CurrentOverviewPage extends StatefulWidget {
  const CurrentOverviewPage({super.key});

  @override
  State<CurrentOverviewPage> createState() => _CurrentOverviewPageState();
}

class _CurrentOverviewPageState extends State<CurrentOverviewPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  ActiveAlarmBloc? _alarmBlocReference;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    OneSignal.Notifications.addForegroundWillDisplayListener((final event) {
      log('onFORE');
      log(event.notification.title.toString());
      log('NOTOTOT');
      log(event.notification.body.toString());
      log(event.notification.additionalData.toString());
      log(event.notification.rawPayload.toString());
      _alarmBlocReference?.add(ActiveAlarmSilentRefresh());
    });

    OneSignal.Notifications.addClickListener((final event) {
      log('BAZNOST');
      final eventId = event.notification.additionalData?['eventId'];
      PendingNavigation.pendingEventId = eventId;
      log(PendingNavigation.pendingEventId.toString());
      log(event.notification.additionalData?['eventId']);
      log(event.notification.additionalData.toString());
    });
    super.initState();
  }

  @override
  void dispose() {
    _alarmBlocReference = null;
    PendingNavigation.pendingEventId = null;
    WidgetsBinding.instance.removeObserver(this);
    //context.read<PoolingCubit>().close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print('app in resumed');
        _alarmBlocReference?.add(ActiveAlarmStarted());
        break;
      case AppLifecycleState.inactive:
        print('app in inactive');
        break;
      case AppLifecycleState.paused:
        print('app in paused');
        break;
      case AppLifecycleState.detached:
        print('app in detached');
        break;
      case AppLifecycleState.hidden:
        print('app in hidden');
    }
  }

  @override
  Widget build(final BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<ActiveAlarmBloc>(
            create: (final context) {
              _alarmBlocReference = ActiveAlarmBloc();
              _alarmBlocReference!.add(ActiveAlarmStarted());
              return _alarmBlocReference!;
            },
          ),
          BlocProvider<UserBloc>(
            create: (final context) => UserBloc()..add(UserStarted()),
          ),
          BlocProvider<SettingsBloc>(
            create: (final context) => SettingsBloc()..add(SettingsStarted()),
          ),
          BlocProvider(
            create: (final context) =>
                PoolingCubit()..start(const Duration(seconds: 1)),
          ),
        ],
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (
            final BuildContext context,
            final SettingsState settingsState,
          ) =>
              BlocBuilder<UserBloc, UserState>(
            builder: (final context, final userState) {
              if (userState is UserLoadFailure) {
                return const UserNotFoundPage();
              }
              if (userState is UserLoadInProgress) {
                return const Material(
                  child: JayProgressIndicator(
                    text: 'Stahuji informace o uživateli',
                  ),
                );
              }
              if (userState is UserLoadSuccess) {
                return content(
                    context,
                    userState,
                    getSettings(settingsState)?.activeAlarmDuration ?? 10,
                    getSettings(settingsState)?.map ?? "Google Maps");
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      );

  Widget content(
    final BuildContext context,
    final UserLoadSuccess userState,
    final int activeAlarmDuration,
    final String mapSettings,
  ) =>
      BlocListener<PoolingCubit, PoolingState>(
        listener: (final BuildContext context, final PoolingState state) {
          if (state is PoolingFetched) {
            if ((DateTime.now().millisecondsSinceEpoch / 1000).toInt() % 20 ==
                0) {
              log("REFETCH!");
              context.read<ActiveAlarmBloc>().add(ActiveAlarmSilentRefresh());
            }
            setState(() {});
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: JayColors.primaryLight,
            title: const Text('Přehled událostí'),
          ),
          body: BlocListener<ActiveAlarmBloc, ActiveAlarmState>(
            listener:
                (final BuildContext context, final ActiveAlarmState state) {
              if (state is ActiveAlarmLoadSuccess) {
                if (PendingNavigation.pendingEventId != null) {
                  try {
                    log("SAMUROS");
                    final event = state.alarms.firstWhere(
                      (final e) =>
                          e.eventId == PendingNavigation.pendingEventId,
                    );
                    PendingNavigation.pendingEventId = null;
                    Navigator.of(context).popUntil((final r) => r.isFirst);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (final c) => EventPage(
                          memberId: userState.memberId,
                          eventId: event.eventId,
                          alarmDto: event,
                          activeAlarmDuration: activeAlarmDuration,
                          mapSettings: mapSettings,
                        ),
                      ),
                    );
                  } on Exception {
                    log("NONOSSOS ");
                  }
                }
              }
            },
            child: BlocBuilder<ActiveAlarmBloc, ActiveAlarmState>(
              builder: (final context, final state) {
                if (state is ActiveAlarmLoadSuccess) {
                  final earlierThan0neDay = state.alarms
                      .where(
                        (final e) =>
                            _isEarlierThan(e.orderSentTimestamp, 86400) &&
                            !_isEarlierThan(
                              e.orderSentTimestamp,
                              60 * activeAlarmDuration,
                            ),
                      )
                      .toList();

                  final activeAlarms = state.alarms
                      .where(
                        (final e) => _isEarlierThan(
                          e.orderSentTimestamp,
                          60 * activeAlarmDuration,
                        ),
                      )
                      .toList();
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<ActiveAlarmBloc>().add(ActiveAlarmStarted());
                      return Future.value(true);
                    },
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        _separator('Aktivní poplachy'),
                        if (activeAlarms.isNotEmpty)
                          ...activeAlarms.map(
                            (final event) => item(
                              event,
                              activeAlarmDuration,
                              () => _openDetail(
                                  context,
                                  event,
                                  activeAlarmDuration,
                                  userState.memberId,
                                  mapSettings),
                            ),
                          ),
                        if (activeAlarms.isEmpty)
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Žádný aktivní poplach',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        _separator('Starší než $activeAlarmDuration minut'),
                        if (earlierThan0neDay.isNotEmpty)
                          ...earlierThan0neDay.map(
                            (final event) => item(
                              event,
                              activeAlarmDuration,
                              () => _openDetail(
                                  context,
                                  event,
                                  activeAlarmDuration,
                                  userState.memberId,
                                  mapSettings),
                            ),
                          ),
                        if (earlierThan0neDay.isEmpty)
                          Text(
                            'Žádný poplach starší $activeAlarmDuration minut',
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _separator(
                              'Záznamy starší 24h naleznete v historii',
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showModalHistory(
                                            userState.memberId, mapSettings);
                                      },
                                      style: const ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                          JayColors.primary,
                                        ),
                                      ),
                                      child: const Text(
                                        'Historie',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                if (state is ActiveAlarmLoadSuccess && state.alarms.isEmpty) {
                  return Center(
                    child: Text(AppLocalizations.of(context)!.eventEmpty),
                  );
                }
                if (state is ActiveAlarmLoadInProgress) {
                  return const Center(
                    child: JayProgressIndicator(
                      text: 'Stahuji data',
                    ),
                  );
                }
                if (state is ActiveAlarmFailure) {
                  return Center(
                    child: JayWhiteText(
                      AppLocalizations.of(context)!.checkConnection,
                      fontSize: 20,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          drawer: JayDrawer(
            mapSettings: mapSettings,
            email: userState.email ?? '',
            name: userState.fullName.replaceAll('.', ''),
            memberId: userState.memberId,
            functionName: userState.functionName,
            onSettingsChanged: () {
              context.read<SettingsBloc>().add(SettingsStarted());
            },
          ),
        ),
      );

  Future<void> _openDetail(
    final BuildContext context,
    final AlarmDto event,
    final int activeAlarmDuration,
    final int memberId,
    final String mapSettings,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (final c) => EventPage(
          memberId: memberId,
          eventId: event.eventId,
          alarmDto: event,
          activeAlarmDuration: activeAlarmDuration,
          mapSettings: mapSettings,
        ),
      ),
    );
    _alarmBlocReference?.add(ActiveAlarmStarted());
  }

  Widget item(final AlarmDto event, final int activeAlarmDuration,
          final VoidCallback callback) =>
      Card(
        color: Colors.white,
        elevation: 6,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: InkWell(
          onTap: callback,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.event,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        event.eventType,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        event.explanation,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Wrap(
                        runSpacing: 4,
                        spacing: 4,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              color: JayColors.secondary,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.group_sharp,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  event.unit,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              color: JayColors.red,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  event.declineCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              color: JayColors.green,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  event.confirmCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_isEarlierThan(
                            event.orderSentTimestamp,
                            60 * activeAlarmDuration,
                          ))
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                color: JayColors.primary,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.timer,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    _currentTimer(event.orderSentTimestamp),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Column(
                  children: [
                    Text(
                      DateFormat('HH:mm', 'cs').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          event.orderSentTimestamp,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      DateFormat('dd.MM.', 'cs').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          event.orderSentTimestamp,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      size: 32,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  String _currentTimer(final int orderSentTimestamp) =>
      (DateFormat('mm:ss').format(
        DateTime(0).add(
          Duration(
            milliseconds:
                DateTime.now().millisecondsSinceEpoch - orderSentTimestamp,
          ),
        ),
      ));

  bool _isEarlierThan(final int orderSentTimestamp, final int seconds) =>
      orderSentTimestamp >=
      DateTime.now().millisecondsSinceEpoch - (seconds * 1000);

  Widget _separator(final String title) => Container(
        margin: const EdgeInsets.all(12),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      );

  void showModalHistory(final memberId, final String mapSettings) {
    showModalBottomSheet(
      enableDrag: false,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (final context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.all(12),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 32,
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Historie událostí',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Starší než 24 hodin',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 8),
              height: MediaQuery.of(context).size.height * 0.70,
              child: EventHistoryList(
                mapSettings: mapSettings,
                memberId: memberId,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SettingsLoadSuccess? getSettings(final SettingsState state) {
    if (state is SettingsLoadSuccess) {
      return state;
    }
    return null;
  }
}
