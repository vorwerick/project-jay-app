import 'package:app/presentation/common/jay_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  final RouterConfig<Object> routerConfig;

  const App({super.key, required this.routerConfig});

  @override
  Widget build(final BuildContext context) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: JayColors.primary,
          ),
          colorScheme: ColorScheme.fromSeed(
            error: const Color(0xFF9d1b25),
            errorContainer: const Color(0xFFea858d),
            seedColor: const Color(0xFFd16014),
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
        builder: (final context, final child) => Material(
          child: child,
        ),
        routerConfig: routerConfig,
      );
}
