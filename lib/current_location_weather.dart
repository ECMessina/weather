import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/constants.dart';

class CurrentLocationWeather extends StatelessWidget {
  const CurrentLocationWeather({super.key, required this.position});

  final Position position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SigColors.medTheme,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Location: ${position.latitude}, ${position.longitude}"),
          const Row(
            children: [
              Icon(
                Icons.sunny,
                color: Colors.amber,
                size: 200,
              ),
            ],
          ),
          const Text(
            'Here\'s what you can expect',
          ),
        ],
      ),
    );
  }
}
