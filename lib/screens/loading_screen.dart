import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_application/services/weather.dart';
import 'package:weather_application/screens/homepage.dart';

class LoadingScreen extends StatefulWidget {
  final String? city;

  LoadingScreen({this.city});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    loadWeatherData();
  }

  Future<void> loadWeatherData() async {
    try {
      Weather weather = Weather();
      var weatherData;

      if (widget.city == null) {
        print('Fetching location-based weather...');
        weatherData = await weather.getLocationWeather();
      } else {
        print('Fetching weather for city: ${widget.city}');
        weatherData = await weather.getSearchWeather(widget.city!);

        if (weatherData == null) {
          print('City not found. Falling back to location-based weather...');
          weatherData = await weather.getLocationWeather();
        } else {
          print('Weather data fetched successfully for ${widget.city}');
        }
      }

      if (weatherData == null) {
        throw Exception('No weather data received.');
      } else if (mounted) {
        print('Weather data fetched successfully. Moving to HomePage...');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomePage(locationWeather: weatherData);
            },
          ),
        );
      }
    } catch (e) {
      print('Error loading weather data: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unable to fetch weather data. Please try again.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitFadingCube(
            color: widget.city == null ? Colors.red : Colors.blue,
            size: 100.0,
          ),
          SizedBox(height: 20),
          Text(
            widget.city == null
                ? 'Fetching weather for your location...'
                : 'Fetching weather for ${widget.city}...',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
