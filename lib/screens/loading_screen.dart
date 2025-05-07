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

      // Fetch weather based on city or location
      if (widget.city == null) {
        // Location-based weather
        weatherData = await weather.getLocationWeather();
      } else {
        // Search-based weather
        weatherData = await weather.getSearchWeather(widget.city!);

        if (weatherData == null) {
          // Fallback to location-based weather if city not found
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'City "${widget.city}" not found. Showing location-based weather instead.',
              ),
            ),
          );

          weatherData = await weather.getLocationWeather();
        }
      }

      if (weatherData == null) {
        throw Exception('No weather data received');
      } else if (mounted) {
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
      print('Error: $e');
      if (mounted) {
        // Handle errors and fallback to location-based weather
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                widget.city == null
                    ? Text(
                      'Unable to fetch location-based weather data. Please try again.',
                    )
                    : Text(
                      'Unable to fetch weather data for "${widget.city}". Showing location-based weather instead.',
                    ),
          ),
        );

        var fallbackWeather = await Weather().getLocationWeather();
        if (fallbackWeather != null && mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomePage(locationWeather: fallbackWeather);
              },
            ),
          );
        }
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
