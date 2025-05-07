import 'package:flutter/material.dart';
import 'package:weather_application/screens/homepage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_application/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    try {
      Weather weather = Weather();
      var weatherData = await weather.getLocationWeather();

      if (weatherData == null) {
        throw Exception('No weather data received');
      } else if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Homepage(locationWeather: weatherData);
            },
          ),
        );
      }
    } catch (e) {
      print('Error: $e'); // Log the error for debugging
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Unable to fetch weather data. Please try again.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SpinKitFadingCube(color: Colors.red, size: 100.0)],
      ),
    );
  }
}
