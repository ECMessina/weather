import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/constants.dart';
import 'package:weather/current_location_weather.dart';
import 'package:weather/location_denied.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  void _determinePosition(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.openAppSettings();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LocationDenied(),
          ),
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
    }

    Position position = await Geolocator.getCurrentPosition();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CurrentLocationWeather(position: position),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Row(
          children: [
            Icon(
              Icons.sunny,
              color: Colors.amber,
              size: 200,
            ),
          ],
        ),
        ElevatedButton(
          style: const ButtonStyle(
            shadowColor: MaterialStatePropertyAll(Colors.white),
            backgroundColor: MaterialStatePropertyAll(SigColors.lightTheme),
            elevation: MaterialStatePropertyAll(20),
            padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(15, 25, 15, 25)),
          ),
          onPressed: () => _determinePosition(context),
          child: Text(
            'What\'s the weather like?',
            style: TextStyles.mainTextStyle,
          ),
        ),
      ],
    );
  }
}
