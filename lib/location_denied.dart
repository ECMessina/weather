import 'package:flutter/material.dart';
import 'package:weather/constants.dart';
import 'package:weather/current_location_weather.dart';
import 'package:weather/search_field.dart';

class LocationDenied extends StatelessWidget {
  const LocationDenied({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SigColors.medTheme,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Row(
            children: [
              Icon(
                Icons.dark_mode,
                color: SigColors.lightTheme,
                size: 200,
              ),
            ],
          ),
          SearchField(onSubmitted: (enteredValue) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => CurrentLocationWeather(
                      searchedValue: enteredValue,
                    )),
              ),
            );
          }),
          TextButton(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: SigColors.veryDarkTheme,
                  ),
                ),
              ),
              child: Text(
                'Get Current Location Weather',
                style: TextStyles.expectTextStyle,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
