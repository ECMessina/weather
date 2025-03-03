import 'package:flutter/material.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/constants.dart';
import 'package:weather/screens/current_location_weather.dart';
import 'package:weather/buttons/start_button.dart';
import 'package:weather/screens/location_denied.dart';
import 'package:weather/alerts/permissions_alert.dart';

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
      if (!mounted) {
        return;
      }
      showDialog(
        context: context,
        builder: (context) {
          return FGBGNotifier(
            onEvent: (FGBGType value) async {
              if (value == FGBGType.foreground) {
                serviceEnabled = await Geolocator.isLocationServiceEnabled();
                if (serviceEnabled) {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    _determinePosition();
                  }
                }
              }
            },
            child: PermissionsAlert(
              text: 'Location services are currently disabled',
              onPressed: () async {
                await Geolocator.openLocationSettings();
              },
            ),
          );
        },
      );

      return;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      if (!mounted) {
        return;
      }

      showDialog(
        context: context,
        builder: (context) {
          return FGBGNotifier(
            onEvent: (FGBGType value) async {
              if (value == FGBGType.foreground) {
                permission = await Geolocator.requestPermission();
                if (permission == LocationPermission.always ||
                    permission == LocationPermission.whileInUse) {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    _determinePosition();
                  }
                }
              }
            },
            child: PermissionsAlert(
              text: 'App location permission is currently denied',
              onPressed: () async {
                await Geolocator.openAppSettings();
              },
            ),
          );
        },
      );

      return;
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) {
        return;
      }

      showDialog(
        context: context,
        builder: (context) {
          return FGBGNotifier(
            onEvent: (FGBGType value) async {
              if (value == FGBGType.foreground) {
                permission = await Geolocator.requestPermission();
                if (permission == LocationPermission.always ||
                    permission == LocationPermission.whileInUse) {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    _determinePosition();
                  }
                } else {
                  if (!context.mounted) {
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocationDenied(),
                    ),
                  );
                }
              }
            },
            child: PermissionsAlert(
              text: 'App location permission is currently denied',
              onPressed: () async {
                await Geolocator.openAppSettings();
              },
            ),
          );
        },
      );

      return;
    }
    setState(() {
      isLoading = true;
    });

    final position = await Geolocator.getCurrentPosition();

    if (!mounted) {
      return;
    }

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
          color: Colors.black.withValues(alpha: .5),
          dismissible: false,
        ),
        kSpinner,
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
            Row(children: [WeatherIcons.sunny]),
            StartButton(
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
