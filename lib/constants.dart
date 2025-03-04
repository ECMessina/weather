import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SigColors {
  static const superDarkTheme = Color.fromARGB(255, 13, 71, 161);
  static const veryDarkTheme = Color.fromARGB(255, 25, 118, 210);
  static const darkTheme = Colors.blue;
  static const medTheme = Color.fromARGB(255, 100, 181, 246);
  static const lightTheme = Color.fromARGB(255, 187, 222, 251);
  static const shadowColor = Colors.white;
  static const searchIconColor = Colors.white;
}

class TextStyles {
  static final mainTextStyle = GoogleFonts.merriweather(
    color: SigColors.darkTheme,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
  static final locationTextStyle = GoogleFonts.merriweather(
    color: SigColors.superDarkTheme,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static final searchTextStyle = GoogleFonts.merriweather(
    color: SigColors.superDarkTheme,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static final expectTextStyle = GoogleFonts.merriweather(
    color: SigColors.veryDarkTheme,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static final hintTextStyle = GoogleFonts.merriweather(
    color: SigColors.superDarkTheme,
    fontSize: 12,
  );
}

const kSpinner = Center(
  child: SpinKitSpinningLines(color: SigColors.lightTheme),
);

class WeatherIcons {
  static const sunny = Icon(
    Icons.sunny,
    color: Colors.amber,
    size: 200,
    // 800
  );
  static const cloudy = Icon(
    Icons.cloud,
    color: Colors.white,
    size: 200,
    // 80x
  );
  static const rain = Icon(
    Icons.cloudy_snowing,
    color: Color.fromRGBO(13, 71, 161, 1),
    size: 200,
    // 3xx && 5xx
  );
  static const storms = Icon(
    Icons.thunderstorm_sharp,
    color: Colors.black,
    size: 200,
    // 2xx
  );
  static const snow = Icon(
    Icons.ac_unit_sharp,
    color: Colors.white,
    size: 200,
    // 6xx
  );
  static const windy = Icon(
    Icons.air,
    color: Color.fromARGB(255, 53, 63, 72),
    size: 200,
    // 7xx
  );
  static const denied = Icon(
    Icons.dark_mode,
    color: SigColors.lightTheme,
    size: 200,
  );
  static const search = Icon(Icons.search, color: SigColors.searchIconColor);
}
