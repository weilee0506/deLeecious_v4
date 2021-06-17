import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

import '../provider/login.dart';

class AdaptiveContextDropdown extends StatefulWidget {
  @override
  _AdaptiveContextDropdownState createState() =>
      _AdaptiveContextDropdownState();
}

class _AdaptiveContextDropdownState extends State<AdaptiveContextDropdown> {
  WeatherFactory wf = new WeatherFactory('58dbf39967ed6036991d250caabcf477',
      language: Language.CHINESE_TRADITIONAL);
  String cityName = 'Taipei';
  String selectedContextValue = 'weekend';
  String weatherGoodBad;
  String weekdayWeekend;
  String dayNight;
  String currentContext;
  List fitContextIntentionFactorSets = [];
  List<String> fitContextIntentionFactorSetsName = [];
  // String selectedIntentionFactorSetName;
  Position _currentLocation;
  int weatherCount = 0;
  int intentionFactorSetIndexForSystemInitiated;
  List contextList = [
    'goodweekdayday',
    'goodweekdaynight',
    'goodweekendday',
    'goodweekendnight',
    'badweekdayday',
    'badweekdaynight',
    'badweekendday',
    'badweekendnight',
  ];

  @override
  void initState() {
    // fitContextIntentionFactorSets = [];
    // fitContextIntentionFactorSetsName = [];
    // get_context();
    // if (Provider.of<Login>(context, listen: false).userData['userGroup'] ==
    //         'user-initiated' ||
    //     Provider.of<Login>(context, listen: false).userData['userGroup'] ==
    //         'mix-initiated' ||
    //     Provider.of<Login>(context, listen: false).userData['userGroup'] ==
    //         'no-personalization') {
    //   get_context();
    // }
    super.initState();
    Geolocator.getCurrentPosition().then((currloc) {
      _currentLocation = currloc;
    });
  }

  void get_context() async {
    Weather w = await wf.currentWeatherByCityName(cityName);
    weatherCount++;
    print('weatherCount: $weatherCount');
    final weather = w.weatherMain;
    if (weather == 'Thunderstorm' ||
        weather == 'Drizzle' ||
        weather == 'Rain') {
      weatherGoodBad = '壞天氣';
    } else {
      weatherGoodBad = '好天氣';
    }

    final day = DateFormat.E().format(DateTime.now());
    if (day == 'Sat' || day == 'Sun') {
      weekdayWeekend = '假日';
    } else {
      weekdayWeekend = '平日';
    }

    final time = DateFormat.H().format(DateTime.now());
    if (int.parse(time) < 18) {
      dayNight = '白天';
    } else {
      dayNight = '晚上';
    }
    currentContext = '$weatherGoodBad$weekdayWeekend$dayNight';
    // for (int i = 0; i < 8; i++) {
    //   if (contextList[i] == currentContext) {
    //     intentionFactorSetIndexForSystemInitiated = i;
    //     print('check');
    //   }
    // }

    Provider.of<Login>(context, listen: false)
        .getCurrentContext(currentContext);
    print('aa $weather');
  }

  Future getContext() async {
    // Geolocator.getCurrentPosition().then((currloc) {
    //   _currentLocation = currloc;
    // });
    //mix-initiated
    if (Provider.of<Login>(context, listen: false).userData['userGroup'] ==
        'mix-initiated') {
      Provider.of<Login>(context, listen: false).resetFitContextSets();

      for (var i = 0;
          i <
              Provider.of<Login>(context, listen: false)
                  .userData['userIntentionFactorSets']
                  .length;
          i++) {
        if (Provider.of<Login>(context, listen: false)
                    .userData['userIntentionFactorSets'][i]
                ['userIntentionFactorSetContext'] ==
            Provider.of<Login>(context, listen: false).currentContext) {
          Provider.of<Login>(context, listen: false).getFitIntentionFactorSets(
              Provider.of<Login>(context, listen: false)
                  .userData['userIntentionFactorSets'][i]);

          Provider.of<Login>(context, listen: false)
              .getFitIntentionFactorSetsName(
                  Provider.of<Login>(context, listen: false)
                          .userData['userIntentionFactorSets'][i]
                      ['userIntentionFactorSetName']);
        }
      }

      // Geolocator.getCurrentPosition(
      //         desiredAccuracy: LocationAccuracy.best,
      //         forceAndroidLocationManager: true)
      //     .then((Position position) {
      //   if (mounted) {
      //     setState(() {
      //       _currentLocation = position;
      //       Provider.of<Login>(context, listen: false)
      //           .getCurrentLocation(_currentLocation);
      //       Provider.of<Login>(context, listen: false)
      //           .getCurrentLatitude(_currentLocation.latitude);
      //       Provider.of<Login>(context, listen: false)
      //           .getCurrentLongitude(_currentLocation.longitude);
      //     });
      //   }
      // }).catchError((e) {
      //   print(e);
      // });
    }

    //user-initiated
    if (Provider.of<Login>(context, listen: false).userData['userGroup'] ==
        'user-initiated') {
      Provider.of<Login>(context, listen: false).resetFitContextSets();
      for (var i = 0;
          i <
              Provider.of<Login>(context, listen: false)
                  .userData['userIntentionFactorSets']
                  .length;
          i++) {
        Provider.of<Login>(context, listen: false).getFitIntentionFactorSets(
            Provider.of<Login>(context, listen: false)
                .userData['userIntentionFactorSets'][i]);

        Provider.of<Login>(context, listen: false)
            .getFitIntentionFactorSetsName(
                Provider.of<Login>(context, listen: false)
                        .userData['userIntentionFactorSets'][i]
                    ['userIntentionFactorSetName']);
      }
      // Geolocator.getCurrentPosition(
      //         desiredAccuracy: LocationAccuracy.best,
      //         forceAndroidLocationManager: true)
      //     .then((Position position) {
      //   if (mounted) {
      //     setState(() {
      //       _currentLocation = position;
      //       Provider.of<Login>(context, listen: false)
      //           .getCurrentLocation(_currentLocation);
      //       Provider.of<Login>(context, listen: false)
      //           .getCurrentLatitude(_currentLocation.latitude);
      //       Provider.of<Login>(context, listen: false)
      //           .getCurrentLongitude(_currentLocation.longitude);
      //     });
      //   }
      // }).catchError((e) {
      //   print(e);
      // });
    }

    //no-personalization
    if (Provider.of<Login>(context, listen: false).userData['userGroup'] ==
        'no-personalization') {
      Provider.of<Login>(context, listen: false).resetFitContextSets();

      Provider.of<Login>(context, listen: false).getFitIntentionFactorSets(
          Provider.of<Login>(context, listen: false)
              .userData['userIntentionFactorSets'][0]);

      // Geolocator.getCurrentPosition(
      //         desiredAccuracy: LocationAccuracy.best,
      //         forceAndroidLocationManager: true)
      //     .then((Position position) {
      //   // if (mounted) {
      //   //   setState(() {
      //   _currentLocation = position;
      //   Provider.of<Login>(context, listen: false)
      //       .getCurrentLocation(_currentLocation);
      //   Provider.of<Login>(context, listen: false)
      //       .getCurrentLatitude(_currentLocation.latitude);
      //   Provider.of<Login>(context, listen: false)
      //       .getCurrentLongitude(_currentLocation.longitude);
      //   //   });
      //   // }
      // }).catchError((e) {
      //   print(e);
      // });
    }

    //system-initiated
    if (Provider.of<Login>(context, listen: false).userData['userGroup'] ==
        'system-initiated') {
      Provider.of<Login>(context, listen: false).resetFitContextSets();

      // if (Provider.of<Login>(context, listen: false)
      //             .userData['userIntentionFactorSets'][0]
      //         ['userIntentionFactorSetContext'] ==
      //     Provider.of<Login>(context, listen: false).currentContext) {
      //   Provider.of<Login>(context, listen: false).getFitIntentionFactorSets(
      //       Provider.of<Login>(context, listen: false)
      //           .userData['userIntentionFactorSets'][0]);
      //   Provider.of<Login>(context, listen: false)
      //       .getSelectedIntentionFactorSet();
      // }
      // if (Provider.of<Login>(context, listen: false)
      //             .userData['userIntentionFactorSets'][1]
      //         ['userIntentionFactorSetContext'] ==
      //     Provider.of<Login>(context, listen: false).currentContext) {
      //   Provider.of<Login>(context, listen: false).getFitIntentionFactorSets(
      //       Provider.of<Login>(context, listen: false)
      //           .userData['userIntentionFactorSets'][1]);
      //   Provider.of<Login>(context, listen: false)
      //       .getSelectedIntentionFactorSet();
      // }
      // if (Provider.of<Login>(context, listen: false)
      //             .userData['userIntentionFactorSets'][2]
      //         ['userIntentionFactorSetContext'] ==
      //     Provider.of<Login>(context, listen: false).currentContext) {
      //   Provider.of<Login>(context, listen: false).getFitIntentionFactorSets(
      //       Provider.of<Login>(context, listen: false)
      //           .userData['userIntentionFactorSets'][2]);
      //   Provider.of<Login>(context, listen: false)
      //       .getSelectedIntentionFactorSet();
      // }
      // if (Provider.of<Login>(context, listen: false)
      //             .userData['userIntentionFactorSets'][3]
      //         ['userIntentionFactorSetContext'] ==
      //     Provider.of<Login>(context, listen: false).currentContext) {
      //   Provider.of<Login>(context, listen: false).getFitIntentionFactorSets(
      //       Provider.of<Login>(context, listen: false)
      //           .userData['userIntentionFactorSets'][3]);
      //   Provider.of<Login>(context, listen: false)
      //       .getSelectedIntentionFactorSet();
      // }
      // if (Provider.of<Login>(context, listen: false)
      //             .userData['userIntentionFactorSets'][4]
      //         ['userIntentionFactorSetContext'] ==
      //     Provider.of<Login>(context, listen: false).currentContext) {
      //   Provider.of<Login>(context, listen: false).getFitIntentionFactorSets(
      //       Provider.of<Login>(context, listen: false)
      //           .userData['userIntentionFactorSets'][4]);
      //   Provider.of<Login>(context, listen: false)
      //       .getSelectedIntentionFactorSet();
      // }
      // if (Provider.of<Login>(context, listen: false)
      //             .userData['userIntentionFactorSets'][5]
      //         ['userIntentionFactorSetContext'] ==
      //     Provider.of<Login>(context, listen: false).currentContext) {
      //   Provider.of<Login>(context, listen: false).getFitIntentionFactorSets(
      //       Provider.of<Login>(context, listen: false)
      //           .userData['userIntentionFactorSets'][5]);
      //   Provider.of<Login>(context, listen: false)
      //       .getSelectedIntentionFactorSet();
      // }
      // if (Provider.of<Login>(context, listen: false)
      //             .userData['userIntentionFactorSets'][6]
      //         ['userIntentionFactorSetContext'] ==
      //     Provider.of<Login>(context, listen: false).currentContext) {
      //   Provider.of<Login>(context, listen: false).getFitIntentionFactorSets(
      //       Provider.of<Login>(context, listen: false)
      //           .userData['userIntentionFactorSets'][6]);
      //   Provider.of<Login>(context, listen: false)
      //       .getSelectedIntentionFactorSet();
      // }
      // if (Provider.of<Login>(context, listen: false)
      //             .userData['userIntentionFactorSets'][7]
      //         ['userIntentionFactorSetContext'] ==
      //     Provider.of<Login>(context, listen: false).currentContext) {
      //   Provider.of<Login>(context, listen: false).getFitIntentionFactorSets(
      //       Provider.of<Login>(context, listen: false)
      //           .userData['userIntentionFactorSets'][7]);
      //   Provider.of<Login>(context, listen: false)
      //       .getSelectedIntentionFactorSet();
      // }
      // Provider.of<Login>(context, listen: false).getFitIntentionFactorSets(
      //     Provider.of<Login>(context, listen: false)
      //         .userData['userIntentionFactorSets'][0]);

      // for (var i = 0;
      //     i <
      //         Provider.of<Login>(context, listen: false)
      //             .userData['userIntentionFactorSets']
      //             .length;
      //     i++) {
      //   if (Provider.of<Login>(context, listen: false)
      //               .userData['userIntentionFactorSets'][i]
      //           ['userIntentionFactorSetContext'] ==
      //       Provider.of<Login>(context, listen: false).currentContext) {
      //     Provider.of<Login>(context, listen: false).getFitIntentionFactorSets(
      //         Provider.of<Login>(context, listen: false)
      //             .userData['userIntentionFactorSets'][i]);
      // Provider.of<Login>(context, listen: false)
      //     .getSelectedIntentionFactorSet();
      // Provider.of<Login>(context, listen: false)
      //     .getSelectedIntentionFactorSetName(
      //         Provider.of<Login>(context, listen: false)
      //                 .userData['userIntentionFactorSets'][i]
      //             ['userIntentionFactorSetName']);
      // Provider.of<Login>(context, listen: false).changecheck();
      //   }
      // }

      // Geolocator.getCurrentPosition(
      //         desiredAccuracy: LocationAccuracy.best,
      //         forceAndroidLocationManager: true)
      //     .then((Position position) {
      //   if (mounted) {
      //     setState(() {
      //       _currentLocation = position;
      //       Provider.of<Login>(context, listen: false)
      //           .getCurrentLocation(_currentLocation);
      //       Provider.of<Login>(context, listen: false)
      //           .getCurrentLatitude(_currentLocation.latitude);
      //       Provider.of<Login>(context, listen: false)
      //           .getCurrentLongitude(_currentLocation.longitude);
      //     });
      //   }
      // }).catchError((e) {
      //   print(e);
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getContext(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          // decoration: BoxDecoration(border: Border.all(color: Colors.green)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ColoredBox(
                child: Text(
                  '現在情境: ${Provider.of<Login>(context, listen: false).currentContext}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'RobotoCondensed',
                    // backgroundColor: Colors.pink,
                  ),
                ),
                // padding: EdgeInsets.all(5),
                color: Colors.pink,
              ),
              // Container(
              //   child: Text('$_currentLocation'),
              // ),
              // SizedBox(
              //   width: 30,
              // ),
              if (Provider.of<Login>(context, listen: false)
                          .userData['userGroup'] ==
                      'mix-initiated' ||
                  Provider.of<Login>(context, listen: false)
                          .userData['userGroup'] ==
                      'user-initiated')
                DropdownButton(
                  value: Provider.of<Login>(context, listen: false)
                              .fitContextIntentionFactorSetsName ==
                          null
                      ? ''
                      : Provider.of<Login>(context, listen: false)
                          .selectedIntentionFactorSetName,
                  icon: Icon(Icons.arrow_drop_down),
                  style: Theme.of(context).textTheme.bodyText2,
                  onChanged: (String newValue) {
                    if (mounted) {
                      setState(() {
                        Provider.of<Login>(context, listen: false)
                            .getSelectedIntentionFactorSetName(newValue);
                      });
                    }
                  },
                  items: Provider.of<Login>(context, listen: false)
                              .fitContextIntentionFactorSetsName ==
                          null
                      ? [].map<DropdownMenuItem<String>>((dynamic value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()
                      : Provider.of<Login>(context, listen: false)
                          .fitContextIntentionFactorSetsName
                          .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                ),
            ],
          ),
        );
      },
    );
  }
}
