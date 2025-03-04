import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/constants.dart';
import 'package:weather/screens/location_denied.dart';
import 'package:weather/alerts/user_entry_error.dart';
import 'package:weather/api_files/weather_response.dart';
import 'package:weather/api_files/weather_service.dart';
import 'package:weather/buttons/search_button.dart';

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
      getSearchedWeather(widget.searchedValue!);
    }
  }

  void getSearchedWeather(String enteredValue) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }

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

        await showDialog(
          context: context,
          builder: (context) {
            return UserEntryError(
              errorText: 'Unable to recognize zip code.',
              onPressed: dismissDialog,
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

        await showDialog(
          context: context,
          builder: (context) {
            return UserEntryError(
              errorText: 'Unable to recognize city name.',
              onPressed: dismissDialog,
              helperText: '*(Example: Woodstock, GA)',
            );
          },
        );
      }
    }

    if (weatherResponse != null) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void dismissDialog() {
    Navigator.pop(context);

    if (weatherResponse == null) {
      Navigator.pop(context);
    }
  }

  Icon getIcon() {
    final weatherId = weatherResponse!.weather[0].id;
    if (weatherId > 800) {
      return WeatherIcons.cloudy;
    } else if (weatherId > 700 && weatherId < 800) {
      return WeatherIcons.windy;
    } else if (weatherId >= 600 && weatherId < 700) {
      return WeatherIcons.snow;
    } else if (weatherId >= 300 && weatherId < 600) {
      return WeatherIcons.rain;
    } else if (weatherId >= 200 && weatherId < 300) {
      return WeatherIcons.storms;
    } else {
      return WeatherIcons.sunny;
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
                    Text(
                      'Current Temperature: ${weatherResponse!.main.temp.toStringAsFixed(0)} °F',
                      style: TextStyles.expectTextStyle,
                    ),
                    Text(
                      'Feels Like: ${weatherResponse!.main.feelsLike.toStringAsFixed(0)} °F',
                      style: TextStyles.expectTextStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [getIcon()]),
                    ),
                    Text(
                      'Humidity: ${weatherResponse!.main.humidity.toStringAsFixed(0)} %',
                      style: TextStyles.expectTextStyle,
                    ),
                    Text(
                      'Wind Speed: ${weatherResponse!.wind.speed.toStringAsFixed(0)} mph',
                      style: TextStyles.expectTextStyle,
                    ),
                    SearchButton(
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
