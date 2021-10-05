import 'package:flutter/material.dart';
import 'package:weather_application/Ui/home_page.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/giving_values/give_values.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Give(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
