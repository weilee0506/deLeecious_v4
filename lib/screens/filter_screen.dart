import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/common_item.dart';
import '../widgets/intentionFactor_input.dart';
import '../provider/login.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter-screen';
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // WeatherFactory wf = new WeatherFactory('58dbf39967ed6036991d250caabcf477',
  //     language: Language.CHINESE_TRADITIONAL);
  // String cityName = 'Taipei';
  // String selectedContextValue = 'weekend';
  // String weatherGoodBad;
  // String weekdayWeekend;
  // String dayNight;
  // String currentContext;
  // List fitContextIntentionFactorSets = [];
  // List<String> fitContextIntentionFactorSetsName = [];
  // // String selectedIntentionFactorSetName;
  // // Position _currentLocation;
  // int weatherCount = 0;
  // int intentionFactorSetIndexForSystemInitiated;
  // List contextList = [
  //   'goodweekdayday',
  //   'goodweekdaynight',
  //   'goodweekendday',
  //   'goodweekendnight',
  //   'badweekdayday',
  //   'badweekdaynight',
  //   'badweekendday',
  //   'badweekendnight',
  // ];

  // @override
  // void initState() {
  //   // get_context();
  //   super.initState();
  // }

  // void get_context() async {
  //   Weather w = await wf.currentWeatherByCityName(cityName);
  //   weatherCount++;
  //   print('weatherCount: $weatherCount');
  //   final weather = w.weatherMain;
  //   if (weather == 'Thunderstorm' ||
  //       weather == 'Drizzle' ||
  //       weather == 'Rain') {
  //     weatherGoodBad = 'bad';
  //   } else {
  //     weatherGoodBad = 'good';
  //   }

  //   final day = DateFormat.E().format(DateTime.now());
  //   if (day == 'Sat' || day == 'Sun') {
  //     weekdayWeekend = 'weekend';
  //   } else {
  //     weekdayWeekend = 'weekday';
  //   }

  //   final time = DateFormat.H().format(DateTime.now());
  //   if (int.parse(time) < 18) {
  //     dayNight = 'day';
  //   } else {
  //     dayNight = 'night';
  //   }
  //   currentContext = '$weatherGoodBad$weekdayWeekend$dayNight';
  //   // for (int i = 0; i < 8; i++) {
  //   //   if (contextList[i] == currentContext) {
  //   //     intentionFactorSetIndexForSystemInitiated = i;
  //   //     print('check');
  //   //   }
  //   // }

  //   Provider.of<Login>(context, listen: false)
  //       .getCurrentContext(currentContext);
  //   print('aa $weather');
  // }

  @override
  void initState() {
    super.initState();
    // _getData(Provider.of<UsedData>(context, listen: false).emailInput);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CommonItem(),
        IntentionFactorInput(),
        // ButtonSet(),
      ],
    );
  }
}
