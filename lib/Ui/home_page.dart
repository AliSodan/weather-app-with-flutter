import 'package:flutter/material.dart';

import 'package:weather_icons/weather_icons.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/Ui/blur_container.dart';

import 'package:intl/intl.dart';
import 'package:weather_application/giving_values/give_values.dart';

import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double tempreture = 13;

  String location = 'London';

  String weather = 'clear';

  String errorMessege = '';

  String initialLocation = '';
  List<double> temp = [0.1, 0.2];
  List locations = [];
  final List<Feature> features = [
    Feature(
      title: "Tempreture",
      color: Colors.orangeAccent,
      data: [
        0.3,
        0.4,
        0.5,
        0.05,
        0.1,
        0.2,
      ],
    ),
  ];
  @override
  void initState() {
    Provider.of<Give>(context, listen: false).getCurrentLocation();

    Provider.of<Give>(context, listen: false).getForecast();

    setState(() {
      weather = Provider.of<Give>(context, listen: false).weather;
    });
    //weather = Provider.of<Give>(context, listen: false).weather;

    super.initState();
  }

  onTextSubmitted(input) {
    setState(() {
      weather = Provider.of<Give>(context, listen: false).weather;
    });
    Provider.of<Give>(context, listen: false)
        .fetchLocation(input.replaceAll(' ', '+'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/$weather.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SingleChildScrollView(
                        child: Center(
                          child: BlurContainer(
                            height: 0.3,
                            width: 0.96,
                            margin: 0.11,
                            leftmargin: 0.0,
                            rightmargin: 0.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Provider.of<Give>(context).icon == ''
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.93,
                                        child: Center(
                                            child: CircularProgressIndicator()))
                                    : Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.02),
                                                    child: Text(
                                                      Provider.of<Give>(context)
                                                          .location,
                                                      style: TextStyle(
                                                        fontSize: 30,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          (Provider.of<Give>(
                                                                          context)
                                                                      .tempreture)
                                                                  .toString() +
                                                              ' °',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      BoxedIcon(
                                                        WeatherIcons.fromString(
                                                            'temp',
                                                            fallback: WeatherIcons
                                                                .thermometer),
                                                        color:
                                                            Color(0xff8A0207),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.01),
                                                        child: Text(
                                                          'Max : ' +
                                                              '  ' +
                                                              Provider.of<Give>(
                                                                      context)
                                                                  .temp_max
                                                                  .toString() +
                                                              ' °',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .indigo),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02),
                                                        child: BoxedIcon(
                                                          WeatherIcons
                                                              .fromString(
                                                            'max',
                                                            fallback:
                                                                WeatherIcons
                                                                    .hot,
                                                          ),
                                                          color: Colors
                                                              .orangeAccent,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          'Min : ' +
                                                              '  ' +
                                                              Provider.of<Give>(
                                                                      context)
                                                                  .temp_min
                                                                  .toString() +
                                                              ' °',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .indigo),
                                                        ),
                                                      ),
                                                      BoxedIcon(
                                                        WeatherIcons.fromString(
                                                          'min',
                                                          fallback: WeatherIcons
                                                              .thermometer_exterior,
                                                        ),
                                                        color: Colors.red,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          'wind : ' +
                                                              '  ' +
                                                              Provider.of<Give>(
                                                                      context)
                                                                  .windSpeed
                                                                  .toString() +
                                                              ' ',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .indigo),
                                                        ),
                                                      ),
                                                      BoxedIcon(
                                                        WeatherIcons.fromString(
                                                          'wind',
                                                          fallback: WeatherIcons
                                                              .day_windy,
                                                        ),
                                                        color: Colors.indigo,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          'humidity : ' +
                                                              '  ' +
                                                              Provider.of<Give>(
                                                                      context)
                                                                  .humidity
                                                                  .toString() +
                                                              ' ',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .indigo),
                                                        ),
                                                      ),
                                                      BoxedIcon(
                                                        WeatherIcons.fromString(
                                                          'humidity',
                                                          fallback: WeatherIcons
                                                              .humidity,
                                                        ),
                                                        color: Colors.indigo,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.00,
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  child: Image.network(
                                                      'http://openweathermap.org/img/wn/' +
                                                          Provider.of<Give>(
                                                                  context)
                                                              .icon +
                                                          '@4x.png'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                              ],
                            ),

                           
                          ),
                        ),
                      ),
                      Provider.of<Give>(context).abrev.length < 7
                          ? Container(
                              height: MediaQuery.of(context).size.height * 0.27,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.transparent,
                              child: ListView.builder(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.height *
                                        0.09),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: 7,
                                itemBuilder: (context, i) => BlurContainer(
                                  height: 0.2,
                                  width: 0.43,
                                  margin: 0.03,
                                  leftmargin: 0.03,
                                  rightmargin: 0.00,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height * 0.27,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.transparent,
                              child: ListView.builder(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.height *
                                        0.09),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount:
                                    Provider.of<Give>(context).abrev.length,
                                itemBuilder: (context, i) => BlurContainer(
                                  height: 0.2,
                                  width: 0.43,
                                  margin: 0.03,
                                  leftmargin: 0.03,
                                  rightmargin: 0.00,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        child: Text(
                                          DateFormat('EEEE').format(
                                            DateTime.now().add(
                                              Duration(days: 1 + i),
                                            ),
                                          ),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.003),
                                        child: Text(
                                          DateFormat('y/M/d').format(
                                            DateTime.now().add(
                                              Duration(days: 1 + i),
                                            ),
                                          ),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01),
                                      Provider.of<Give>(context).abrev.length <
                                              7
                                          ? CircularProgressIndicator()
                                          : Container(
                                              child: Image.network(
                                                  'https://www.metaweather.com//static/img/weather/ico/' +
                                                      Provider.of<Give>(context)
                                                          .abrev[i] +
                                                      '.ico'),
                                            ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      Container(
                                        child: Text(
                                          'Max Temp: ' +
                                              Provider.of<Give>(context)
                                                  .maxTemp[i]
                                                  .toString(),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                            'Min Temp: ' +
                                                Provider.of<Give>(context)
                                                    .minTemp[i]
                                                    .toString(),
                                            style: TextStyle(fontSize: 18)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      BlurContainer(
                        height: 0.29,
                        width: 0.96,
                        margin: 0.03,
                        leftmargin: 0.0,
                        rightmargin: 0.0,
                        child: LineGraph(
                          features: features,
                          size: Size(MediaQuery.of(context).size.width * 0.96,
                              MediaQuery.of(context).size.height * 0.275),
                          labelX: [
                            'Day 1',
                            'Day 2',
                            'Day 3',
                            'Day 4',
                            'Day 5',
                            'Day 6'
                          ],
                          labelY: ['25%', '45%', '65%', '75%', '85%', '100%'],
                          showDescription: false,
                          graphColor: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  buildFloatingSearchBar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      onSubmitted: (input) {
        locations.add(input);

        setState(() {
          Provider.of<Give>(context, listen: false).abrev.clear();
          Provider.of<Give>(context, listen: false).maxTemp.clear();
          Provider.of<Give>(context, listen: false).minTemp.clear();
          Provider.of<Give>(context, listen: false).days.clear();
          weather = Provider.of<Give>(context, listen: false).weather;
        });
        Provider.of<Give>(context, listen: false)
            .fetchLocation(input.replaceAll(' ', '+'));

        // Call your model, bloc, controller here.
      },
      backgroundColor: Colors.grey[300],
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),

      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {
              Provider.of<Give>(context, listen: false).abrev.clear();
              Provider.of<Give>(context, listen: false).maxTemp.clear();
              Provider.of<Give>(context, listen: false).minTemp.clear();
              Provider.of<Give>(context, listen: false).days.clear();
              weather = Provider.of<Give>(context, listen: false).weather;
              Provider.of<Give>(context, listen: false).getCurrentLocation();
              Provider.of<Give>(context, listen: false).getForecast();
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.grey[300],
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: locations.map((val) {
                return ListView.builder(
                    itemCount: locations.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return ListTile(
                        leading: Icon(Icons.place),
                        title: Text('$val'),
                      );
                    });
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
