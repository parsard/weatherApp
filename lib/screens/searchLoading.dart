import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_application/services/weather.dart';
import 'package:weather_application/screens/search.dart';

import 'homepage.dart';
import 'loading_screen.dart';

class SearchLoading extends StatefulWidget {
  SearchLoading({required this.city});
  String city;

  @override
  _SearchLoadingState createState() => _SearchLoadingState();
}

class _SearchLoadingState extends State<SearchLoading> {
  @override
  void initState() {
    super.initState();
    searchData(widget.city);
  }

  void searchData(String city) async {
    try {
      Weather weather = Weather();
      var searchData = await weather.getSearchWeather(city);

      if (searchData == null) {
        if (mounted) {
          // Show Snackbar only if the widget is still in the widget tree
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('City not found!')));
        }
        return;
      }

      if (mounted) {
        // Navigate to Search result screen if data exists
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Search(locationWeather: searchData);
            },
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unable to fetch data due to an error.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SpinKitFadingCube(color: Colors.blue, size: 100.0)],
      ),
    );
  }
}
