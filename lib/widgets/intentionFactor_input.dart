import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';

import 'intentionFactor_set.dart';

import 'adaptiveContext_dropdown.dart';
import 'button_set.dart';

import '../provider/login.dart';

class IntentionFactorInput extends StatefulWidget {
  @override
  _IntentionFactorInputState createState() => _IntentionFactorInputState();
}

String contextValue = 'weekend';

class _IntentionFactorInputState extends State<IntentionFactorInput> {
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
  //   get_context();
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
  Widget build(BuildContext context) {
    return Consumer<Login>(
      builder: (context, login, child) {
        // print(usedData.factorSetValue.factorStatus);
        return Expanded(
          // child: Container(
          // height: 500,
          child: Column(
            children: <Widget>[
              // if (login.userData['userGroup'] == 'user-initiated' ||
              //     login.userData['userGroup'] == 'mix-initiated' ||
              //     login.userData['userGroup'] == 'system-initiated')
              AdaptiveContextDropdown(),
              // if (login.userData['userGroup'] == 'user-initiated')
              //   IntentionFactorSetUserInitiated(),
              // if (login.userData['userGroup'] == 'mix-initiated')
              IntentionFactorSet(),
              ButtonSet()
            ],
          ),
          // ),
        );
      },
    );
  }
}
