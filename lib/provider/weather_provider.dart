import 'package:flutter/material.dart';
import 'package:weather_application/services/weather.dart';

class WeatherProvider extends ChangeNotifier {
  var long;
  var lat;
  var temperature;
  var feelsLike;
  var description;
  var humidity;
  var windSpeed;
  var cityName;
  var country;
  var id;
  var min;
  var max;
  var pressure;
  var animation;
  var background;
  bool isLoading = true;

  final Weather _weatherService = Weather();

  Future<void> fetchWeather({String? city}) async {
    isLoading = true;
    notifyListeners();

    try {
      var weatherData;

      if (city == null) {
        weatherData = await _weatherService.getLocationWeather();
      } else {
        weatherData = await _weatherService.getSearchWeather(city);
        if (weatherData == null) {
          weatherData = await _weatherService.getLocationWeather();
        }
      }

      updateWeatherData(weatherData);
    } catch (e) {
      print('Error fetching weather data: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // void updateWeatherData(dynamic weatherData) {
  //   if (weatherData != null) {
  //     long = weatherData['coord']['lon']?.toDouble() ?? 0.0;
  //     lat = weatherData['coord']['lat']?.toDouble() ?? 0.0;
  //     temperature = weatherData['main']['temp']?.toDouble() ?? 0.0;
  //     feelsLike = weatherData['main']['feels_like']?.toDouble() ?? 0.0;
  //     description = weatherData['weather'][0]['description'] ?? 'Unavailable';
  //     humidity = weatherData['main']['humidity'] ?? 0;
  //     windSpeed = weatherData['wind']['speed']?.toDouble() ?? 0.0;
  //     cityName = weatherData['name'] ?? 'Unknown';
  //     country = weatherData['sys']['country'] ?? 'Unknown';
  //     id = weatherData['weather'][0]['id'] ?? 800;
  //     min = weatherData['main']['temp_min']?.toDouble() ?? 0.0;
  //     max = weatherData['main']['temp_max']?.toDouble() ?? 0.0;
  //     pressure = weatherData['main']['pressure'] ?? 0;
  //     animation = _weatherService.getWeatherAnimation(id);
  //     background = _weatherService.getWeatherBackground(id);

  //     notifyListeners();
  //   }
  // }
  void updateWeatherData(dynamic weatherData) {
    if (weatherData != null) {
      long = weatherData['coord']['lon']?.toDouble() ?? 0.0;
      lat = weatherData['coord']['lat']?.toDouble() ?? 0.0;
      temperature = weatherData['main']['temp']?.toDouble() ?? 0.0;
      feelsLike = weatherData['main']['feels_like']?.toDouble() ?? 0.0;
      description = weatherData['weather'][0]['description'] ?? 'Unavailable';
      humidity = weatherData['main']['humidity'] ?? 0;
      windSpeed = weatherData['wind']['speed']?.toDouble() ?? 0.0;
      cityName = weatherData['name'] ?? 'Unknown';
      country = weatherData['sys']['country'] ?? 'Unknown';
      id = weatherData['weather'][0]['id'] ?? 800;
      min = weatherData['main']['temp_min']?.toDouble() ?? 0.0;
      max = weatherData['main']['temp_max']?.toDouble() ?? 0.0;
      pressure = weatherData['main']['pressure'] ?? 0;
      animation = _weatherService.getWeatherAnimation(id);
      background = _weatherService.getWeatherBackground(id);

      notifyListeners();
    }
  }
}
