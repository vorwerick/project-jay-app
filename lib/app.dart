import 'package:app/application/cubit/login/login_cubit.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/pages/event_page.dart';
import 'package:app/presentation/pages/main_page.dart';
import 'package:app/presentation/pages/register_device_page.dart';
import 'package:app/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {

  const App({super.key});

  @override
  Widget build(final BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: JayColors.primaryLight,
          ),
          colorScheme: ColorScheme.fromSeed(
            error: const Color(0xFF9d1b25),
            errorContainer: const Color(0xFFea858d),
            seedColor: JayColors.primaryLight,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          //Locale('en'),
          Locale('cs'),
        ],

        home: BlocProvider<LoginCubit>(
          create: (final context) => LoginCubit(),
          child: BlocBuilder<LoginCubit, LoginState>(
              builder: (final context, final state) {
            if (state is LoggedIn) {
              return MainPage();
            }
            if (state is NotLogged) {
              return RegisterDevicePage();
            }
            context.read<LoginCubit>().checkAuth();
            return SplashPage();
          }),
        ),
      );
}
