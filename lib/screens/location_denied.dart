import 'package:flutter/material.dart';
import 'package:weather/buttons/restart_button.dart';
import 'package:weather/constants.dart';
import 'package:weather/screens/current_location_weather.dart';
import 'package:weather/buttons/search_button.dart';

class LocationDenied extends StatelessWidget {
  const LocationDenied({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SigColors.medTheme,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Row(children: [WeatherIcons.denied]),
          SearchButton(
            onSubmitted: (enteredValue) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      ((context) =>
                          CurrentLocationWeather(searchedValue: enteredValue)),
                ),
              );
            },
          ),
          RestartButton(
            text: 'Get Current Location Weather',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
