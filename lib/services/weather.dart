import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

const apiKey = 'f0d4309e6ac0a14fb21391f749b3c158';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getWeatherIcons(int icon) async {
    NetworkHelper networkHelper =
        NetworkHelper('http://openweathermap.org/img/wn/$icon@2x.png');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  IconData getWeatherIcon(int condition) {
    if (condition < 300) {
      return FlutterIcons.wi_thunderstorm_wea;
    } else if (condition < 400) {
      return FlutterIcons.wi_raindrops_wea;
    } else if (condition < 600) {
      return FlutterIcons.wi_rain_wea;
    } else if (condition < 700) {
      return FlutterIcons.wi_day_snow_wea;
    } else if (condition < 800) {
      return FlutterIcons.wi_fog_wea;
    } else if (condition == 800) {
      return FlutterIcons.wi_wu_clear_wea;
    } else if (condition <= 804) {
      return FlutterIcons.wi_cloud_wea;
    } else {
      return FlutterIcons.weather_night_mco;
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
