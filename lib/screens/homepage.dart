import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_application/services/weather.dart';
import 'package:weather_application/widgets/search_custom.dart';
import 'package:weather_application/widgets/weather_details.dart';
import 'package:weather_application/widgets/weather_stats_table.dart';
import 'package:weather_icons/weather_icons.dart';

import 'package:weather_application/screens/search.dart';
import 'package:weather_application/screens/searchLoading.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_cloud_bg.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_color_bg.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_night_star_bg.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_rain_snow_bg.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_thunder_bg.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/utils/image_utils.dart';
import 'package:flutter_weather_bg_null_safety/utils/print_utils.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';

class Homepage extends StatefulWidget {
  Homepage({this.locationWeather});
  final locationWeather;

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var long;
  var lat;
  var temperature;
  var feelsLike;
  var description;
  var humidity;
  var windSpeed;
  var cityName;
  var country;
  var id;
  var min;
  var max;
  var pressure;
  var animation;

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
      // backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SearchCustom(
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
          ],
        ),
      ),

      body: Container(
        margin: EdgeInsets.only(top: 0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(background), fit: BoxFit.cover)),
        child: Column(
          children: [
            SizedBox(height: 150),
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
