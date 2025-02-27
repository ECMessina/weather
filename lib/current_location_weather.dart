import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/constants.dart';
import 'package:weather/location_denied.dart';
import 'package:weather/user_entry_error.dart';
import 'package:weather/weather_response.dart';
import 'package:weather/weather_service.dart';
import 'package:weather/search_field.dart';

class CurrentLocationWeather extends StatefulWidget {
  const CurrentLocationWeather({super.key, this.position, this.searchedValue});

  final Position? position;
  final String? searchedValue;

  @override
  State<CurrentLocationWeather> createState() => _CurrentLocationWeatherState();
}

class _CurrentLocationWeatherState extends State<CurrentLocationWeather> {
  WeatherResponse? weatherResponse;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getWeather();
  }

  void getWeather() async {
    if (widget.position != null) {
      try {
        weatherResponse = await WeatherService.getWeatherByLatLong(
          widget.position!,
        );

        if (!mounted) {
          return;
        }
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        if (!mounted) {
          return;
        }

        showDialog(
            context: context,
          barrierColor: Colors.black.withValues(alpha: .5),
            builder: (context) {
              return UserEntryError(
                errorText: 'Position unable to be found.',
              onPressed:
                  (() => Navigator.push(
                      context,
                    MaterialPageRoute(
                      builder: (context) => const LocationDenied(),
                    ),
                    )),
              );
          },
        );
      }
    } else {
      setState(() {
        isLoading = false;
      });
      getSearchedWeather(widget.searchedValue!);
    }
  }

  void getSearchedWeather(String enteredValue) async {
    setState(() {
      isLoading = true;
    });

    enteredValue = enteredValue.trim();

    if (RegExp("[0-9]{5}").hasMatch(enteredValue)) {
      try {
        weatherResponse = await WeatherService.getWeatherByZipCode(
          int.parse(enteredValue),
        );
      } catch (e) {
        if (!mounted) {
          return;
        }

        showDialog(
            context: context,
            builder: (context) {
              return UserEntryError(
                errorText: 'Unable to recognize zip code.',
                onPressed: () => Navigator.pop(context),
              );
          },
        );
      }
    } else {
      try {
        weatherResponse = await WeatherService.getWeatherByName(enteredValue);
      } catch (e) {
        if (!mounted) {
          return;
        }

        showDialog(
            context: context,
            builder: (context) {
              return UserEntryError(
                errorText: 'Unable to recognize city name.',
                onPressed: () => Navigator.pop(context),
              );
          },
        );
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  Icon getIcon() {
    final weatherId = weatherResponse!.weather[0].id;
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
      body:
          isLoading
          ? kSpinner
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "In ${weatherResponse!.name}",
                    style: TextStyles.locationTextStyle,
                    textAlign: TextAlign.center,
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
                      child: Row(children: [getIcon()]),
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
                  SearchField(
                    onSubmitted: (enteredValue) {
                      getSearchedWeather(enteredValue);
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
