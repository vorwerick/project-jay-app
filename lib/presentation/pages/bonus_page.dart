import 'dart:async';
import 'dart:math';

import 'package:app/application/bloc/settings/version/settings_bloc.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EasterEggPage extends StatefulWidget {
  const EasterEggPage({super.key});

  @override
  State<EasterEggPage> createState() => _EasterEggPageState();
}

class _EasterEggPageState extends State<EasterEggPage> {
  static const int GamePrepared = 0;
  static const int GameRunningWait = 1;
  static const int GameRunningAlarm = 2;
  static const int GameResult = 3;

  int gameState = GamePrepared;

  int? resultTime;
  int? alarmTime;
  Timer? timer;

  int? sessionStarted;

  @override
  void initState() {
    sessionStarted = DateTime.now().millisecondsSinceEpoch;
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => BlocProvider<SettingsBloc>(
        create: (final BuildContext context) => SettingsBloc()..add(SettingsStarted()),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (final BuildContext context, final state) {
            int? result;
            if (state is SettingsLoadSuccess) {
              result = state.gameTimeResult;
            }
            return Scaffold(
              body: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [JayColors.primary, JayColors.primaryLight])),
                  child: () {
                    switch (gameState) {
                      case GameRunningWait:
                        return _contentGameRunningWait();
                      case GameRunningAlarm:
                        return _contentGameRunningAlarm(context, result);
                      case GameResult:
                        return _contentGameResult();
                      default:
                        return _contentGamePrepared(result);
                    }
                  }()),
            );
          },
        ),
      );

  Widget _contentGamePrepared(final int? result) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 64,
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Během následujících pěti vteřin bude vyhlášen cvičný poplach, který prověří tvoji rychlou reakci.',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    final randomMilliseconds = 600 + Random().nextInt(4500);
                    timer?.cancel();
                    timer =
                        Timer(Duration(milliseconds: randomMilliseconds), () {
                      alarmTime = DateTime.now().millisecondsSinceEpoch;
                      if (mounted) {
                        setState(() {
                          gameState = GameRunningAlarm;
                        });
                      }
                    });
                    setState(() {
                      gameState = GameRunningWait;
                    });
                  },
                  child: const Text('Připraven!')),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nejlepší výsledek: ${result != null ? "${result / 1000}s" : "žádný"}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      );

  Widget _contentGameRunningWait() => const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: JayColors.primary,
          strokeAlign: 24,
          strokeWidth: 4,
        ),
      );

  Widget _contentGameRunningAlarm(
          final BuildContext context, final int? previousResult) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 4),
            child: Card(
              color: Colors.white,
              elevation: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          'Cvičný poplach!',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 22),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Icon(
                        Icons.warning,
                        size: 32,
                        color: JayColors.primary,
                      ))
                ],
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.flip(
                flipX: true,
                child: const CircularProgressIndicator(
                  backgroundColor: JayColors.primary,
                  color: Colors.white,
                  strokeAlign: 24,
                  strokeWidth: 4,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Card(
              elevation: 16,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8, right: 64, top: 4),
                          child: Text(
                            'Odpoveď na výjezd',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FloatingActionButton.extended(
                            heroTag: const Key('accept-game'),
                            onPressed: () {
                              _acceptAlarm(context, previousResult);
                            },
                            icon: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 28,
                            ),
                            backgroundColor: JayColors.green,
                            label: const Text(
                              'Jdu',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          FloatingActionButton.extended(
                            heroTag: const Key('decline-game'),
                            label: const Text(
                              'Nejdu',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                            onPressed: () {},
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 28,
                            ),
                            backgroundColor: JayColors.red,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  Widget _contentGameResult() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Tvoje reakce',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 32),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Text(
                  "${(resultTime! / 1000)}s",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 68),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Ukončit')),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        timer?.cancel();
                        setState(() {
                          timer = null;
                          alarmTime = null;
                          resultTime = null;
                          gameState = GamePrepared;
                        });
                      },
                      child: const Text('Znovu')),
                ],
              )
            ],
          ),
        ],
      );

  void _acceptAlarm(final BuildContext context, final int? previousResult) {
    final res = DateTime.now().millisecondsSinceEpoch - alarmTime!;
    if (!(previousResult != null && previousResult < res)) {
      context.read<SettingsBloc>().add(SettingsSetGameTimeResult(time: res));
    }

    setState(() {
      gameState = GameResult;
      resultTime = res;
    });
  }
}
