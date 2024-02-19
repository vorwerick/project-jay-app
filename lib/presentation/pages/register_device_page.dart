import 'package:app/application/bloc/device/device_registration_bloc.dart';
import 'package:app/presentation/components/jay_text_form_field.dart';
import 'package:app/presentation/navigation/app_routes.dart';
import 'package:app/presentation/utils/snack_bar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class RegisterDevicePage extends StatefulWidget {
  const RegisterDevicePage({super.key});

  @override
  State<RegisterDevicePage> createState() => _RegisterDevicePageState();
}

class _RegisterDevicePageState extends State<RegisterDevicePage> {
  final TextEditingController _deviceKeyController = TextEditingController();

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => DeviceRegistrationBloc(),
        child: Scaffold(
          body: BlocListener<DeviceRegistrationBloc, DeviceRegistrationState>(
            listener: (final context, final state) {
              if (state is DeviceRegistrationSuccess) {
                context.go(AppRoutes.home.path);
              }
              if (state is DeviceRegistrationFailure) {
                SnackBarUtils.showError(context, 'registration failed');
              }

              if (state is DeviceRegistrationInvalid) {
                SnackBarUtils.showWarning(context, 'invalid input');
              }
            },
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      JayTextFormField(
                        controller: _deviceKeyController,
                        labelText: AppLocalizations.of(context)!.activationKey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Builder(
                        builder: (final context) => ElevatedButton(
                          onPressed: () => {
                            BlocProvider.of<DeviceRegistrationBloc>(context)
                                .add(DeviceRegistrationPressed(_deviceKeyController.text)),
                          },
                          child: Text(AppLocalizations.of(context)!.deviceRegistration),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
