import 'package:flutter/material.dart';
import 'package:hello_world/screens/bmi_screen.dart';
import 'package:hello_world/screens/intro_screen.dart';
import 'package:hello_world/screens/weather_screen.dart';
import 'package:hello_world/screens/sessions_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(const GlobeApp());
}

class GlobeApp extends StatelessWidget {
  const GlobeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      routes: {
        '/': (context) => const IntroScreen(),
        '/bmi': (context) => const BmiScreen(),
        '/weather': (context) => const WeatherScreen(),
        '/training': (context) => const SessionScreen(),
      },
      initialRoute: '/',
    );
  }
}
