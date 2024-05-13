import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/constants.dart';
import 'package:weather/current_location_weather.dart';
import 'package:weather/elevated_search_button.dart';
import 'package:weather/location_denied.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
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

    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: SpinKitSpinningLines(
              color: SigColors.superDarkTheme,
            ),
          );
        });

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
        ElevatedSearchButton(
          onTap: () => _determinePosition(context),
          text: 'What\'s the weather like?',
        ),
      ],
    );
  }
}
