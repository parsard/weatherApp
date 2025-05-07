import 'package:flutter/material.dart';

class WeatherStatsTable extends StatelessWidget {
  final double feelsLike;
  final double minTemp;
  final double maxTemp;
  final int humidity;
  final double windSpeed;
  final int pressure;

  WeatherStatsTable({
    required this.feelsLike,
    required this.minTemp,
    required this.maxTemp,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            Column(
              children: [
                Text(
                  'Feels Like:',
                  style: TextStyle(fontFamily: 'Merriweather', fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text('${feelsLike.toStringAsFixed(0)}°C', style: TextStyle(height: 1.5, fontSize: 30)),
              ],
            ),
            Column(
              children: [
                Text(
                  'Min Temp:',
                  style: TextStyle(fontFamily: 'Merriweather', fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text('${minTemp.toStringAsFixed(0)}°C', style: TextStyle(height: 1.5, fontSize: 30)),
              ],
            ),
            Column(
              children: [
                Text(
                  'Max Temp:',
                  style: TextStyle(fontFamily: 'Merriweather', fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text('${maxTemp.toStringAsFixed(0)}°C', style: TextStyle(height: 1.5, fontSize: 30)),
              ],
            ),
          ],
        ),
        TableRow(
          children: [
            Column(
              children: [
                Text(
                  'Humidity:',
                  style: TextStyle(fontFamily: 'Merriweather', fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text('$humidity%', style: TextStyle(height: 1.5, fontSize: 30)),
              ],
            ),
            Column(
              children: [
                Text(
                  'Windspeed:',
                  style: TextStyle(fontFamily: 'Merriweather', fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text('${windSpeed.toStringAsFixed(0)}%', style: TextStyle(height: 1.5, fontSize: 30)),
              ],
            ),
            Column(
              children: [
                Text(
                  'Pressure:',
                  style: TextStyle(fontFamily: 'Merriweather', fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text('$pressure mb', style: TextStyle(height: 1.5, fontSize: 30)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
