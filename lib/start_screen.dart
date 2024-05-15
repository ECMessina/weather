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
              color: SigColors.lightTheme,
            ),
          );
        });

    Position position = await Geolocator.getCurrentPosition();
    // await Future.delayed(const Duration(seconds: 5));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CurrentLocationWeather(position: position),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final jsonText = '{"coord":{"lon":-84.49,"lat":34.08},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"base":"stations","main":{"temp":71.24,"feels_like":71.73,"temp_min":67.51,"temp_max":75.09,"pressure":1008,"humidity":78},"visibility":10000,"wind":{"speed":11.5,"deg":250},"clouds":{"all":75},"dt":1715785904,"sys":{"type":2,"id":2010262,"country":"US","sunrise":1715769365,"sunset":1715819565},"timezone":-14400,"id":4231874,"name":"Woodstock","cod":200}';
    // final userMap = jsonDecode(jsonText) as Map<String, dynamic>;
    // final weatherResponse = WeatherResponse.fromJson(userMap);
    // debugPrint('${weatherResponse.weather[0].description}');

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
