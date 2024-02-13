import 'package:app/application/bloc/settings/version/settings_bloc.dart';
import 'package:app/presentation/components/jay_container.dart';
import 'package:app/presentation/components/jay_progress_indicator.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:app/presentation/pages/widgets/list/list_checkbox.dart';
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
        body: BlocProvider(
          create: (final context) => SettingsBloc()..add(SettingsStarted()),
          child: JayContainer(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: BlocBuilder<SettingsBloc, SettingsState>(
                builder: (final context, final state) {
                  if (state is SettingsLoadSuccess) {
                    return Column(
                      children: [
                        ListCheckbox(
                          AppLocalizations.of(context)!.textToSpeech,
                          isChecked: state.isTttEnabled,
                          onChanged: (final bool value) {
                            context.read<SettingsBloc>().add(SettingsEnableTTSPressed(value));
                          },
                        ),
                      ],
                    );
                  }
                  return const JayProgressIndicator();
                },
              ),
            ),
          ),
        ),
      );
}
