import 'dart:io';

import 'package:app/application/bloc/settings/version/app_version_bloc.dart';
import 'package:app/application/bloc/settings/version/settings_bloc.dart';
import 'package:app/presentation/components/jay_container.dart';
import 'package:app/presentation/components/jay_progress_indicator.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:app/presentation/pages/widgets/list/list_checkbox.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: JayWhiteText(AppLocalizations.of(context)!.settings),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<AppVersionBloc>(
              create: (final context) =>
                  AppVersionBloc()..add(AppVersionStarted()),
            ),
            BlocProvider(
              create: (final context) => SettingsBloc()..add(SettingsStarted()),
            ),
          ],
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (final context, final state) {
              if (state is SettingsLoadInProgress) {
                return const CircularProgressIndicator();
              }
              if (state is SettingsLoadSuccess) {
                return JayContainer(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        if (Platform.isAndroid)
                          InkWell(
                            onTap: () async {
                              {
                                bool? isAutoStartEnabled =
                                    await DisableBatteryOptimization
                                        .isAutoStartEnabled;
                                if (isAutoStartEnabled == true) {
                                  await DisableBatteryOptimization
                                      .showEnableAutoStartSettings(
                                    'Povolení funkce Auto Start',
                                    'Pro správné fungování aplikace je potřeba povolit funkce Auto-start',
                                  );
                                }
                                bool? isBatteryOptimizationDisabled =
                                    await DisableBatteryOptimization
                                        .isBatteryOptimizationDisabled;
                                if (isBatteryOptimizationDisabled == true) {
                                  await DisableBatteryOptimization
                                      .showDisableBatteryOptimizationSettings();
                                }
                                bool? isManBatteryOptimizationDisabled =
                                    await DisableBatteryOptimization
                                        .isManufacturerBatteryOptimizationDisabled;
                                if (isManBatteryOptimizationDisabled == true) {
                                  await DisableBatteryOptimization
                                      .showDisableManufacturerBatteryOptimizationSettings(
                                    'Optimalizace baterie',
                                    'Pro správné fungování aplikace je potřeba zakázat optimalizaci baterie',
                                  );
                                }
                                bool? isAllOptimizationDisabled =
                                    await DisableBatteryOptimization
                                        .isAllBatteryOptimizationDisabled;
                                if (isAllOptimizationDisabled == true) {
                                  await DisableBatteryOptimization
                                      .showDisableAllOptimizationsSettings(
                                    'Povolení funkce Auto Start',
                                    'Pro správné fungování aplikace je potřeba povolit funkce Auto-start',
                                    'Optimalizace baterie',
                                    'Pro správné fungování aplikace je potřeba zakázat optimalizaci baterie',
                                  );
                                }
                              }
                            },
                            child: Card(
                              child: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.all(16),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Nastavit optimalizaci baterie',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Wrap(
                                          children: [
                                            Text(
                                              'Pro správné fungování notifikací, je potřeba\nzakázat nebo vypnout optimalizaci baterie',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.arrow_forward),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        BlocBuilder<SettingsBloc, SettingsState>(
                          builder: (final context, final state) {
                            if (state is SettingsLoadSuccess) {
                              return Card(
                                child: Container(
                                  margin: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      ListCheckbox(
                                        AppLocalizations.of(context)!
                                            .textToSpeech,
                                        isChecked: state.isTttEnabled,
                                        onChanged: (final bool value) {
                                          context.read<SettingsBloc>().add(
                                                SettingsEnableTTSPressed(value),
                                              );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return const JayProgressIndicator(
                              text: 'Načítám nastavení',
                            );
                          },
                        ),
                        // if (Platform.isAndroid)
                        if (false)
                          InkWell(
                            onTap: () {
                              final settingsBloc = context.read<SettingsBloc>();
                              showDialog(
                                context: context,
                                builder: (final context) => Dialog(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 16, bottom: 16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Zvuk notifikace',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        ListView(
                                          shrinkWrap: true,
                                          children: [
                                            ListTile(
                                              onTap: () {
                                                settingsBloc.add(
                                                  SettingsSetNotificationSound(
                                                    sound: 'fire_siren',
                                                  ),
                                                );
                                                Navigator.pop(context);
                                              },
                                              title: const Text('Požár'),
                                              trailing:
                                                  state.notificationSound ==
                                                          'fire_siren'
                                                      ? const Icon(Icons.check)
                                                      : null,
                                            ),
                                            ListTile(
                                              onTap: () {
                                                settingsBloc.add(
                                                  SettingsSetNotificationSound(
                                                    sound: 'siren',
                                                  ),
                                                );
                                                Navigator.pop(context);
                                              },
                                              title: const Text('Siréna'),
                                              trailing:
                                                  state.notificationSound ==
                                                          'siren'
                                                      ? const Icon(Icons.check)
                                                      : null,
                                            ),
                                            ListTile(
                                              onTap: () {
                                                settingsBloc.add(
                                                  SettingsSetNotificationSound(
                                                    sound: 'alarm',
                                                  ),
                                                );
                                                Navigator.pop(context);
                                              },
                                              title: const Text('Poplach'),
                                              trailing:
                                                  state.notificationSound ==
                                                          'alarm'
                                                      ? const Icon(Icons.check)
                                                      : null,
                                            ),
                                            ListTile(
                                              onTap: () {
                                                settingsBloc.add(
                                                  SettingsSetNotificationSound(
                                                    sound: 'bit',
                                                  ),
                                                );
                                                Navigator.pop(context);
                                              },
                                              title: const Text('Siréna 8-bit'),
                                              trailing:
                                                  state.notificationSound ==
                                                          'bit'
                                                      ? const Icon(Icons.check)
                                                      : null,
                                            ),
                                            ListTile(
                                              onTap: () {
                                                settingsBloc.add(
                                                  SettingsSetNotificationSound(
                                                    sound: 'none',
                                                  ),
                                                );
                                                Navigator.pop(context);
                                              },
                                              title: const Text('Žádný'),
                                              trailing:
                                                  state.notificationSound ==
                                                          'none'
                                                      ? const Icon(Icons.check)
                                                      : null,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              child: Container(
                                margin: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Zvuk notifikace při vyhlášení poplachu',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Wrap(
                                      children: [
                                        Text(
                                          soundNameMapper(
                                              state.notificationSound),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        InkWell(
                          onTap: () {
                            final settingsBloc = context.read<SettingsBloc>();
                            showDialog(
                              context: context,
                              builder: (final context) => Dialog(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 16, bottom: 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Trvání aktivního výjezdu',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      ListView(
                                        shrinkWrap: true,
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              settingsBloc.add(
                                                SettingsSetActiveAlarmDuration(
                                                  minutes: 5,
                                                ),
                                              );
                                              Navigator.pop(context);
                                            },
                                            title: const Text('5 minut'),
                                            trailing:
                                                state.activeAlarmDuration == 5
                                                    ? const Icon(Icons.check)
                                                    : null,
                                          ),
                                          ListTile(
                                            onTap: () {
                                              settingsBloc.add(
                                                SettingsSetActiveAlarmDuration(
                                                  minutes: 10,
                                                ),
                                              );
                                              Navigator.pop(context);
                                            },
                                            title: const Text('10 minut'),
                                            trailing:
                                                state.activeAlarmDuration == 10
                                                    ? const Icon(Icons.check)
                                                    : null,
                                          ),
                                          ListTile(
                                            onTap: () {
                                              settingsBloc.add(
                                                SettingsSetActiveAlarmDuration(
                                                  minutes: 15,
                                                ),
                                              );
                                              Navigator.pop(context);
                                            },
                                            title: const Text('15 minut'),
                                            trailing:
                                                state.activeAlarmDuration == 15
                                                    ? const Icon(Icons.check)
                                                    : null,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: Container(
                              margin: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'Doba trvání aktivního poplachu',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                        '${state.activeAlarmDuration} minut',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            final settingsBloc = context.read<SettingsBloc>();
                            showDialog(
                              context: context,
                              builder: (final context) => Dialog(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 16, bottom: 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Výběr mapového podkladu',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      ListView(
                                        shrinkWrap: true,
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              settingsBloc.add(
                                                SettingsSetMap(
                                                  map: "Google Maps",
                                                ),
                                              );
                                              Navigator.pop(context);
                                            },
                                            title: const Text('Google Maps'),
                                            trailing: state.map == 'Google Maps'
                                                ? const Icon(Icons.check)
                                                : null,
                                          ),
                                          ListTile(
                                            onTap: () {
                                              settingsBloc.add(
                                                SettingsSetMap(
                                                  map: "Mapy.cz",
                                                ),
                                              );
                                              Navigator.pop(context);
                                            },
                                            title: const Text('Mapy.cz'),
                                            trailing: state.map == 'Mapy.cz'
                                                ? const Icon(Icons.check)
                                                : null,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: Container(
                              margin: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'Mapový podklad',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                        state.map,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      );

  String soundNameMapper(final String notificationSoundNameRaw) {
    switch (notificationSoundNameRaw) {
      case 'none':
        return 'Žádný';
      case 'alarm':
        return 'Poplach';
      case 'siren':
        return 'Siréna';
      case 'bit':
        return 'Siréna 8-bit';
      default:
        return 'Požár';
    }
  }
}
