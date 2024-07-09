import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/constants.dart';
import 'package:weather/weather_response.dart';
import 'package:weather/weather_service.dart';

class CurrentLocationWeather extends StatefulWidget {
  const CurrentLocationWeather({super.key, required this.position});

  final Position position;

  @override
  State<CurrentLocationWeather> createState() => _CurrentLocationWeatherState();
}

class _CurrentLocationWeatherState extends State<CurrentLocationWeather> {
  WeatherResponse? weatherResponse;

  @override
  void initState() {
    super.initState();

    getWeather();
  }

  void getWeather() async {
    weatherResponse = await WeatherService.getWeatherByLatLong(widget.position);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SigColors.medTheme,
          const Row(
            children: [
              Icon(
                Icons.sunny,
                color: Colors.amber,
                size: 200,
      body: weatherResponse == null
          ? kSpinner
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "In ${weatherResponse!.name}",
                    style: TextStyles.locationTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Low: ${weatherResponse!.main.tempMin.toStringAsFixed(0)}°F",
                        style: TextStyles.locationTextStyle,
                      ),
                      Text(
                        "High: ${weatherResponse!.main.tempMax.toStringAsFixed(0)}°F",
                        style: TextStyles.locationTextStyle,
                      ),
                    ],
                  ),
              ),
            ],
          ),
          Text(
            'Here\'s what you can expect',
            style: TextStyles.expectTextStyle,
          ),
        ],
      ),
    );
  }
}
