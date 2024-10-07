import 'package:app/presentation/components/jay_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(final BuildContext context) => SafeArea(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              JayTextFormField(
                labelText: AppLocalizations.of(context)!.email,
              ),
              const SizedBox(
                height: 10,
              ),
              JayTextFormField(
                labelText: AppLocalizations.of(context)!.password,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () => {},
                child: Text(AppLocalizations.of(context)!.login),
              )
            ],
          ),
        )),
      );
}
