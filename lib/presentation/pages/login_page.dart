import 'package:app/presentation/components/jay_text_form_field.dart';
import 'package:app/presentation/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(final BuildContext context) {
    return SafeArea(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const JayTextFormField(
              labelText: 'Email',
            ),
            const SizedBox(
              height: 10,
            ),
            const JayTextFormField(
              labelText: 'Password',
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () => {context.go(AppRoutes.home.path)},
              child: const Text('Login'),
            )
          ],
        ),
      )),
    );
  }
}
