import 'package:flutter/material.dart';
import 'package:weather_application/screens/loading_screen.dart';
import 'package:weather_application/services/location.dart';
import 'package:weather_application/services/weather.dart';
import 'package:weather_application/widgets/search_custom.dart';
import 'package:weather_application/widgets/weather_details.dart';
import 'package:weather_application/widgets/weather_stats_table.dart';

class HomePage extends StatefulWidget {
  final dynamic locationWeather;

  HomePage({this.locationWeather});

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
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
  bool isLoading = true;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
    fetchLocationAndWeather();
  }

  Future<void> fetchLocationAndWeather() async {
    try {
      // Fetch the user’s location
      Location location = Location();
      await location.getCurrentLocation();

      // Update state with latitude and longitude
      lat = location.latitude;
      long = location.longitude;

      // Fetch weather data for the current location
      var weatherData = await Weather().getLocationWeather();

      // Update the UI with the fetched weather data
      updateUI(weatherData);
    } catch (e) {
      print('Error fetching location/weather data: $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  void updateUI(dynamic weatherData) {
    if (weatherData != null) {
      setState(() {
        long = weatherData['coord']['lon']?.toDouble() ?? 0.0;
        lat = weatherData['coord']['lat']?.toDouble() ?? 0.0;
        temperature = weatherData['main']['temp']?.toDouble() ?? 0.0;
        feelsLike = weatherData['main']['feels_like']?.toDouble() ?? 0.0;
        description = weatherData['weather'][0]['description'] ?? 'Unavailable';
        humidity = weatherData['main']['humidity'] ?? 0;
        windSpeed = weatherData['wind']['speed']?.toDouble() ?? 0.0;
        cityName = weatherData['name'] ?? 'Unknown';
        country = weatherData['sys']['country'] ?? 'Unknown';
        id = weatherData['weather'][0]['id'] ?? 800;
        min = weatherData['main']['temp_min']?.toDouble() ?? 0.0;
        max = weatherData['main']['temp_max']?.toDouble() ?? 0.0;
        pressure = weatherData['main']['pressure'] ?? 0;
        animation = Weather().getWeatherAnimation(id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String background = Weather().getWeatherBackground(id);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SearchCustom(
          controller: controller,
          onSearch: (String city) async {
            try {
              // Fetch weather data for the searched city
              var weatherData = await Weather().getSearchWeather(city);

              // Update the UI with the fetched weather data
              updateUI(weatherData);
            } catch (e) {
              print('Error fetching weather data for city: $e');
            }
          },
        ),
      ),
      body: Stack(
        children: [
          // The background image
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(background),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // A gradient overlay on top of the background
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.4), // Darker at the top
                  Colors.black.withOpacity(0.4), // Lighter at the bottom
                ],
              ),
            ),
          ),

          // Content of the screen
          Column(
            children: [
              const SizedBox(height: 150),
              WeatherDetails(
                cityName: cityName,
                country: country,
                animation: animation,
                temperature: temperature,
                description: description,
              ),
              const SizedBox(height: 30),
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
        ],
      ),
    );
  }
}
