import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/provider/weather_provider.dart';
import 'package:weather_application/screens/homepage.dart';

class LoadingScreen extends StatelessWidget {
  final String? city;

  const LoadingScreen({this.city});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (weatherProvider.isLoading) {
        weatherProvider.fetchWeather(city: city ?? 'Default City');
      }
    });

    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        // Show loading spinner while fetching data
        if (weatherProvider.isLoading) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpinKitFadingCube(color: Colors.blue, size: 100.0),
                const SizedBox(height: 20),
                Text(
                  city == null ? 'Fetching weather for your location...' : 'Fetching weather for $city...',
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        // Transition to HomePage after fetching data
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        });

        return const SizedBox(); // Empty widget while navigating
      },
    );
  }
}
