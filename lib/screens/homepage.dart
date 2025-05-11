import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/provider/weather_provider.dart';
import 'package:weather_application/widgets/search_custom.dart';
import 'package:weather_application/widgets/weather_details.dart';
import 'package:weather_application/widgets/weather_stats_table.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    if (weatherProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    String background = weatherProvider.background ?? 'images/yellow.jpg';
    print('Background Image Path: $background');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SearchCustom(
          controller: TextEditingController(),
          onSearch: (String city) async {
            await weatherProvider.fetchWeather(city: city);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(background), fit: BoxFit.cover)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.4), Colors.black.withOpacity(0.4)],
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 150),
              WeatherDetails(
                cityName: weatherProvider.cityName,
                country: weatherProvider.country,
                animation: weatherProvider.animation,
                temperature: weatherProvider.temperature,
                description: weatherProvider.description,
              ),
              const SizedBox(height: 30),
              WeatherStatsTable(
                feelsLike: weatherProvider.feelsLike,
                minTemp: weatherProvider.min,
                maxTemp: weatherProvider.max,
                humidity: weatherProvider.humidity,
                windSpeed: weatherProvider.windSpeed,
                pressure: weatherProvider.pressure,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
