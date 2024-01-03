import 'package:flutter/material.dart';

import 'presentation/navigation/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC02222),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 20),
          ),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFC02222),
          inversePrimary: Color(0xFFA83434),
          onPrimary: Colors.blue,
          secondary: Colors.white,
          background: Color(0xFF4b4a4a),
          onBackground: Colors.white,
          tertiary: Colors.deepPurple,
          surface: Color(0xFFA83434),
          onSurface: Colors.black,
          surfaceVariant: Colors.white,
        ),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return Material(
          child: child,
        );
      },
      routerConfig: Routes.create(),
    );
  }
}
