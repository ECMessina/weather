import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:weather/weather_response.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const _apiKey = '84ebe15e64b9de33720d14b09af5b38c';

  static Future<WeatherResponse> getWeatherByLatLong(Position position) async {
    final response = await http.get(Uri.parse('$_baseUrl?lat=${position.latitude}&lon=${position.longitude}&appid=$_apiKey&units=imperial'));
    // await Future.delayed(const Duration(seconds: 2));
    if (response.statusCode == 200) {
      throw Exception('Failed to load weather data');

      return WeatherResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  static Future<WeatherResponse> getWeatherByName(String name) async {
    final response = await http.get(Uri.parse('$_baseUrl?q=$name,us&appid=$_apiKey&units=imperial'));

    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  static Future<WeatherResponse> getWeatherByZipCode(int zip) async {
    final response = await http.get(Uri.parse('$_baseUrl?zip=$zip,us&appid=$_apiKey&units=imperial'));
    await Future.delayed(const Duration(seconds: 2));
    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  static Future<WeatherResponse> getWeatherByPostalCode(dynamic zip) async {
    final response = await http.get(Uri.parse('$_baseUrl?zip=$zip,ca&appid=$_apiKey&units=imperial'));
    await Future.delayed(const Duration(seconds: 2));
    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
