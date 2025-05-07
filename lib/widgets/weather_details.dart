import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherDetails extends StatelessWidget {
  final String cityName;
  final String country;
  final String animation;
  final double temperature;
  final String description;

  WeatherDetails({
    required this.cityName,
    required this.country,
    required this.animation,
    required this.temperature,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_pin, color: Colors.red, size: 40),
            SizedBox(width: 10),
            Text('$cityName, $country', style: TextStyle(fontFamily: 'Merriweather', height: 1.5, fontSize: 30)),
          ],
        ),
        Center(
          child: SizedBox(
            height: 150,
            width: 150,
            child: Lottie.asset(animation), // Use the animation path here
          ),
        ),
        SizedBox(height: 30),
        Text('${temperature.toStringAsFixed(0)}°C', style: TextStyle(height: 1.5, fontSize: 80)),
        Text(description, style: TextStyle(fontFamily: 'Merriweather', height: 0.5, fontSize: 20)),
      ],
    );
  }
}
