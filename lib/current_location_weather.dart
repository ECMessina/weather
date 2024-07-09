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

  Icon getIcon() {
    final weatherId = weatherResponse!.weather[0].id;
    // const weatherId = 801;
    if (weatherId > 800) {
      return WeatherIcon.cloudy;
    } else if (weatherId > 700 && weatherId < 800) {
      return WeatherIcon.windy;
    } else if (weatherId >= 600 && weatherId < 700) {
      return WeatherIcon.snow;
    } else if (weatherId >= 300 && weatherId < 600) {
      return WeatherIcon.rain;
    } else if (weatherId >= 200 && weatherId < 300) {
      return WeatherIcon.storms;
    } else {
      return WeatherIcon.sunny;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SigColors.medTheme,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        getIcon(),
                      ],
                    ),
                  ),
                  Text(
                    'Here\'s what you can expect:',
                    style: TextStyles.expectTextStyle,
                  ),
                  Text(
                    'Current Temperature: ${weatherResponse!.main.temp.toStringAsFixed(0)}°F',
                    style: TextStyles.expectTextStyle,
                  ),
                  Text(
                    'Feels Like: ${weatherResponse!.main.feelsLike.toStringAsFixed(0)}°F',
                    style: TextStyles.expectTextStyle,
                  ),
                ],
              ),
            ),
    );
  }
}
