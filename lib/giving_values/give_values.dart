import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Give extends ChangeNotifier {
  String location = 'London';

  double tempreture = 14.5;

  String weather = 'clear';

  String icon = '';

  int humidity = 0;

  int pressure = 0;

  int visibility = 0;

  int windSpeed = 0;

  String description = '';

  double temp_max = 0.0;
  double temp_min = 0.0;

  String latitude = '';

  String longtitude = '';

  String initialLocation = '';

  int woeid = 324;

  List maxTemp = [];
  List minTemp = [];

  List abrev = [];
  List days = [];
  // String locationMeta = 'https://www.metaweather.com/api/location/$woeid/';

  String searchLocationApi =
      'https://api.openweathermap.org/data/2.5/weather?q=';

  String metricDegree = '&appid=bf612fe54abf9c0b1b1dc48f7e8dad8a&units=metric';

  void fetchLocation(String input) async {
    var locationResult =
        await http.get(Uri.parse(searchLocationApi + input + metricDegree));
    print('inputvalue=$input');
    var result = jsonDecode(locationResult.body);

    location = result['name'];

    tempreture = result['main']['temp'];

    icon = result['weather'][0]['icon'];

    weather = result['weather'][0]['main'].replaceAll(' ', '').toLowerCase();
    humidity = result['main']['humidity'].round();

    windSpeed = result['wind']['speed'].round();

    temp_max = result['main']['temp_max'];
    temp_min = result['main']['temp_min'];

    var searching = await http.get(Uri.parse(
        'https://www.metaweather.com/api/location/search/?query=$input'));
    var result2 = jsonDecode(searching.body);
    woeid = result2[0]['woeid'];
    abrev.clear();
    maxTemp.clear();
    minTemp.clear();
    for (var i = 0; i <= 7; i++) {
      var searchForDate = await http.get(Uri.parse(
          'https://www.metaweather.com/api/location/$woeid/' +
              DateFormat('y/M/d')
                  .format(DateTime.now().add(Duration(days: 1 + i)))
                  .toString()));
      var result2 = jsonDecode(searchForDate.body);
      print(DateFormat('y/M/d')
          .format(DateTime.now().add(Duration(days: 1 + i)))
          .toString());

      abrev.add(result2[0]["weather_state_abbr"]);
      maxTemp.add(result2[0]["max_temp"].round());
      minTemp.add(result2[0]["min_temp"].round());
      print(abrev);
      print(maxTemp);
      print(minTemp);
    }
    notifyListeners();
  }

  getForecast() async {
    var currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    var lat = currentPosition.latitude;
    var lon = currentPosition.longitude;

    var searchwoeid = await http.get(Uri.parse(
        'https://www.metaweather.com/api/location/search/?lattlong=$lat,$lon'));
    var result = json.decode(searchwoeid.body);

    woeid = result[0]['woeid'];

    for (var i = 0; i <= 7; i++) {
      var searchForDate = await http.get(Uri.parse(
          'https://www.metaweather.com/api/location/$woeid/' +
              DateFormat('y/M/d')
                  .format(DateTime.now().add(Duration(days: 1 + i)))
                  .toString()));
      var result2 = jsonDecode(searchForDate.body);
      print(DateFormat('y/M/d')
          .format(DateTime.now().add(Duration(days: 1 + i)))
          .toString());
      days.add(DateFormat('y/M/d')
          .format(DateTime.now().add(Duration(days: 1 + i)))
          .toString());
      abrev.add(result2[0]["weather_state_abbr"]);
      maxTemp.add(result2[0]["max_temp"].round());
      minTemp.add(result2[0]["min_temp"].round());
      print(abrev);
      print(maxTemp);
      print(minTemp);
    }
    notifyListeners();
  }

  getCurrentLocation() async {
    var currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    var lat = currentPosition.latitude;
    var lon = currentPosition.longitude;

    latitude = lat.toString();
    longtitude = lon.toString();
    print(latitude);
    print(longtitude);

    print('initialLocation after giving it a value =' + initialLocation);
    var locationResult = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longtitude&appid=bf612fe54abf9c0b1b1dc48f7e8dad8a' +
            metricDegree));

    var result = jsonDecode(locationResult.body);

    location = result['name'];

    tempreture = result['main']['temp'];

    icon = result['weather'][0]['icon'];

    weather = result['weather'][0]['main'].replaceAll(' ', '').toLowerCase();
    humidity = result['main']['humidity'].round();

    windSpeed = result['wind']['speed'].round();

    temp_max = result['main']['temp_max'];
    temp_min = result['main']['temp_min'];

    notifyListeners();
  }
}
