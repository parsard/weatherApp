import 'package:weather_application/services/location.dart';
import 'package:weather_application/services/connection.dart';

const apiKey = 'efa27f9b2c2d2d8b7484ba75a8526a72';

class Weather {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    print('Latitude: ${location.latitude}, Longitude: ${location.longitude}');

    Connection connection = Connection(
      'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric',
    );
    print(
      'API URL: https://api.openweathermap.org/data/2.5/onecall?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric',
    );

    var weatherData = await connection.getWeatherData();
    return weatherData;
  }

  Future<dynamic> getSearchWeather(String city) async {
    try {
      // Construct the URL for city-based weather queries
      Connection searchLocation = Connection(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric',
      );

      // Fetch weather data from the API
      var weatherData = await searchLocation.getWeatherData();

      // Log the fetched weather data
      print('Fetched weather data for city: $city');
      return weatherData;
    } catch (e) {
      print('Error fetching weather for city: $e');
      return null; // Return null if there was an error fetching data
    }
  }

  String getWeatherBackground(int condition) {
    if (condition < 300) {
      return 'images/thunder.jpg';
    } else if (condition < 600) {
      return 'images/rain.jpg';
    } else if (condition < 700) {
      return 'images/snow.jpg';
    } else if (condition < 800) {
      return 'images/fog.jpg';
    } else if (condition == 800) {
      return 'images/yellow.jpg';
    } else if (condition <= 804) {
      return 'images/cloudy.jpg';
    } else {
      return 'images/yellow.jpg'; // Default background
    }
  }

  String getWeatherAnimation(int condition) {
    if (condition < 300) {
      return 'animations/thinder.json'; //thunder
    } else if (condition < 600) {
      return 'animations/rain.json'; // rain
    } else if (condition < 700) {
      return 'animations/snow.json'; //snowing
    } else if (condition < 800) {
      return 'animations/fog.json'; //foggy
    } else if (condition == 800) {
      return 'animations/sunny.json'; //sunny
    } else if (condition <= 804) {
      return 'animations/cloud.json'; //cloudy
    } else {
      return 'animations/sunny.json'; // Default animation
    }
  }
}
