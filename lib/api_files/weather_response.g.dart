// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    WeatherResponse(
      weather:
          (json['weather'] as List<dynamic>)
              .map((e) => Weather.fromJson(e as Map<String, dynamic>))
              .toList(),
      main: Main.fromJson(json['main'] as Map<String, dynamic>),
      wind: Wind.fromJson(json['wind'] as Map<String, dynamic>),
      clouds: Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
      sys: Sys.fromJson(json['sys'] as Map<String, dynamic>),
      name: json['name'] as String,
    );

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
    <String, dynamic>{
      'weather': instance.weather,
      'main': instance.main,
      'wind': instance.wind,
      'clouds': instance.clouds,
      'sys': instance.sys,
      'name': instance.name,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
  id: (json['id'] as num).toInt(),
  main: json['main'] as String,
  description: json['description'] as String,
  icon: json['icon'] as String,
);

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
  'id': instance.id,
  'main': instance.main,
  'description': instance.description,
  'icon': instance.icon,
};

Main _$MainFromJson(Map<String, dynamic> json) => Main(
  temp: (json['temp'] as num).toDouble(),
  feelsLike: (json['feels_like'] as num).toDouble(),
  humidity: (json['humidity'] as num).toInt(),
);

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
  'temp': instance.temp,
  'feels_like': instance.feelsLike,
  'humidity': instance.humidity,
};

Wind _$WindFromJson(Map<String, dynamic> json) =>
    Wind(speed: (json['speed'] as num).toDouble());

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
  'speed': instance.speed,
};

Clouds _$CloudsFromJson(Map<String, dynamic> json) =>
    Clouds(all: (json['all'] as num).toInt());

Map<String, dynamic> _$CloudsToJson(Clouds instance) => <String, dynamic>{
  'all': instance.all,
};

Sys _$SysFromJson(Map<String, dynamic> json) => Sys(
  country: json['country'] as String,
  sunset: (json['sunset'] as num).toInt(),
);

Map<String, dynamic> _$SysToJson(Sys instance) => <String, dynamic>{
  'country': instance.country,
  'sunset': instance.sunset,
};
