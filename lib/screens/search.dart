import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_application/screens/homepage.dart';
import 'package:weather_application/services/weather.dart';
import 'package:weather_application/screens/searchLoading.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:weather_application/screens/loading_screen.dart';
import 'package:weather_application/widgets/search_custom.dart';
import 'package:weather_application/widgets/weather_details.dart';
import 'package:weather_application/widgets/weather_stats_table.dart';

class Search extends StatefulWidget {
  Search({this.locationWeather});
  final locationWeather;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var long;
  var lat;
  var temperature;
  var feelsLike;
  late String description;
  var humidity;
  var windSpeed;
  late String cityName;
  var country;
  var id;
  late double min;
  late double max;
  late int pressure;
  late String animation;

  TextEditingController Controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    if (weatherData != null) {
      setState(() {
        long = weatherData['coord']['lon']?.toDouble() ?? 0.0; // Ensure it's a double
        lat = weatherData['coord']['lat']?.toDouble() ?? 0.0; // Ensure it's a double
        temperature = weatherData['main']['temp']?.toDouble() ?? 0.0; // Ensure it's a double
        feelsLike = weatherData['main']['feels_like']?.toDouble() ?? 0.0; // Ensure it's a double
        description = weatherData['weather'][0]['description'] ?? 'Unavailable';
        humidity = weatherData['main']['humidity'] ?? 0;
        windSpeed = weatherData['wind']['speed']?.toDouble() ?? 0.0; // Ensure it's a double
        cityName = weatherData['name'] ?? 'Unknown';
        country = weatherData['sys']['country'] ?? 'Unknown';
        id = weatherData['weather'][0]['id'] ?? 800;
        min = weatherData['main']['temp_min']?.toDouble() ?? 0.0; // Ensure it's a double
        max = weatherData['main']['temp_max']?.toDouble() ?? 0.0; // Ensure it's a double
        pressure = weatherData['main']['pressure'] ?? 0;
        animation = Weather().getWeatherAnimation(id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String background = Weather().getWeatherBackground(id);
    animation = Weather().getWeatherAnimation(id);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(height: 150),
            Expanded(
              child: SearchCustom(
                controller: Controller,
                onSearch: (String city) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SearchLoading(city: city);
                      },
                    ),
                  );
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.house, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoadingScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(background), fit: BoxFit.cover)),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            WeatherDetails(
              cityName: cityName,
              country: country,
              animation: animation,
              temperature: temperature,
              description: description,
            ),
            SizedBox(height: 30),
            WeatherStatsTable(
              feelsLike: feelsLike,
              minTemp: min,
              maxTemp: max,
              humidity: humidity,
              windSpeed: windSpeed,
              pressure: pressure,
            ),
          ],
        ),
      ),
    );
  }
}
