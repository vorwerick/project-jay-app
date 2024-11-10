import 'package:app/application/bloc/user/user_bloc.dart';
import 'package:app/application/cubit/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserNotFoundPage extends StatelessWidget {
  const UserNotFoundPage({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                        BlocProvider.of<UserBloc>(
                          context,
                        ).add(UserStarted());
                      },
                      child: const Text('Opakovat'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<LoginCubit>().logout();
                      },
                      child: const Text('Nová registrace'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
