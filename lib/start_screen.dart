import 'package:flutter/material.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/constants.dart';
import 'package:weather/current_location_weather.dart';
import 'package:weather/elevated_search_button.dart';
import 'package:weather/location_denied.dart';
import 'package:weather/user_choices_alert.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool isLoading = false;

  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      showDialog(
        context: context,
        builder: (context) {
          return FGBGNotifier(
            onEvent: (FGBGType value) async {
              if (value == FGBGType.foreground) {
                serviceEnabled = await Geolocator.isLocationServiceEnabled();
                if (serviceEnabled) {
                  Navigator.of(context).pop();
                  _determinePosition();
                }
              }
            },
            child: UserChoicesAlert(
                text: 'Location services are currently disabled',
                onPressed: () async {
                  await Geolocator.openLocationSettings();
                }),
          );
        },
      );

      return;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      showDialog(
        context: context,
        builder: (context) {
          return FGBGNotifier(
            onEvent: (FGBGType value) async {
              if (value == FGBGType.foreground) {
                permission = await Geolocator.requestPermission();
                if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
                  Navigator.of(context).pop();
                  _determinePosition();
                }
              }
            },
            child: UserChoicesAlert(
                text: 'App location permission is currently denied',
                onPressed: () async {
                  await Geolocator.openAppSettings();
                }),
          );
        },
      );

      return;
    }

    if (permission == LocationPermission.deniedForever) {
      showDialog(
        context: context,
        builder: (context) {
          return FGBGNotifier(
            onEvent: (FGBGType value) async {
              if (value == FGBGType.foreground) {
                permission = await Geolocator.requestPermission();
                if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
                  Navigator.of(context).pop();
                  _determinePosition();
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LocationDenied()),
                  );
                }
              }
            },
            child: UserChoicesAlert(
                text: 'App location permission is currently denied',
                onPressed: () async {
                  await Geolocator.openAppSettings();
                }),
          );
        },
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    final position = await Geolocator.getCurrentPosition();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CurrentLocationWeather(position: position),
      ),
    );
  }

  Widget buildLoadingScreen() {
    return Stack(
      children: [
        ModalBarrier(
          color: Colors.black.withOpacity(0.5),
          dismissible: false,
        ),
        kSpinner
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
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
              onTap: _determinePosition,
              text: 'What\'s the weather like?',
            ),
          ],
        ),
        if (isLoading) buildLoadingScreen(),
      ],
    );
  }
}
