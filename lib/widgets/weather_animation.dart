import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherAnimation extends StatelessWidget {
  final String weatherCondition;
  final double height; // Height of the animation
  final double width; // Width of the animation

  const WeatherAnimation({
    Key? key,
    required this.weatherCondition,
    this.height = 200,
    this.width = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String animation = _getAnimationForWeather(weatherCondition);

    // Load the weather animation
    return Center(
      child: Lottie.asset(
        animation,
        height: height,
        width: width,
        fit: BoxFit.contain,
      ),
    );
  }

  String _getAnimationForWeather(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return 'animations/sunny.json'; // Add Lottie file for "Clear"
      case 'clouds':
        return 'animations/cloudy.json'; // Add Lottie file for "Clouds"
      case 'rain':
        return 'animations/rainy.json'; // Add Lottie file for "Rain"
      case 'snow':
        return 'animations/snowy.json'; // Add Lottie file for "Snow"
      case 'thunderstorm':
        return 'animations/thunderstorm.json'; // Add Lottie file for "Thunderstorm"
      default:
        return 'animations/default.json'; // Default animation for unknown conditions
    }
  }
}
