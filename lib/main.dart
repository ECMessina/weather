import 'package:flutter/material.dart';
import 'package:weather/constants.dart';
import 'package:weather/start_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: SigColors.medTheme,
        body: StartScreen(),
      ),
    );
  }
}
