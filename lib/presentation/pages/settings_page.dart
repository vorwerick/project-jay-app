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
          child: JayContainer(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Nastavit optimalizaci baterie",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                        "Pro správné fungování notifikací, je potřeba\nzakázat nebo vypnout optimalizaci baterie",
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
                                  AppLocalizations.of(context)!.textToSpeech,
                                  isChecked: state.isTttEnabled,
                                  onChanged: (final bool value) {
                                    context
                                        .read<SettingsBloc>()
                                        .add(SettingsEnableTTSPressed(value));
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const JayProgressIndicator(
                        text: "Načítám nastavení",
                      );
                    },
                  ),
                  if (false)
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: Container(
                              margin: EdgeInsets.only(top: 16, bottom: 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Zvuk notifikace",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  ...List.generate(2, (index) {
                                    return ListTile(
                                      onTap: () {},
                                      title: Text("zvuk"),
                                      trailing: Icon(Icons.check),
                                      leading: IconButton(
                                        icon: Icon(Icons.play_arrow),
                                        onPressed: () {},
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "Vybrat zvuk notifikace",
                                style: TextStyle(fontSize: 16),
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    "Zvuk zazní při vyhlášení poplachu.",
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
                ],
              ),
            ),
          ),
        ),
      );
}
