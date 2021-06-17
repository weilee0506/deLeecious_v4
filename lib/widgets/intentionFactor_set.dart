import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';

import '../provider/login.dart';

class IntentionFactorSet extends StatefulWidget {
  @override
  _IntentionFactorSetState createState() => _IntentionFactorSetState();
}

class _IntentionFactorSetState extends State<IntentionFactorSet> {
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
    Provider.of<Login>(context, listen: false)
        .getSelectedIntenitonFactorsetForSystemInitiated(
            Provider.of<Login>(context, listen: false).get_context());

    print('hi');
    super.initState();
  }

  void get_context() async {
    Weather w = await wf.currentWeatherByCityName(cityName);
    weatherCount++;
    print('weatherCount: $weatherCount');
    final weather = w.weatherMain;
    if (weather == 'Thunderstorm' ||
        weather == 'Drizzle' ||
        weather == 'Rain') {
      weatherGoodBad = 'bad';
    } else {
      weatherGoodBad = 'good';
    }

    final day = DateFormat.E().format(DateTime.now());
    if (day == 'Sat' || day == 'Sun') {
      weekdayWeekend = 'weekend';
    } else {
      weekdayWeekend = 'weekday';
    }

    final time = DateFormat.H().format(DateTime.now());
    if (int.parse(time) < 18) {
      dayNight = 'day';
    } else {
      dayNight = 'night';
    }
    currentContext = '$weatherGoodBad$weekdayWeekend$dayNight';

    Provider.of<Login>(context, listen: false)
        .getCurrentContext(currentContext);
    print('aa $weather');
  }

  Widget buildIntentionFactorDropdownButton(
    BuildContext context,
    String title,
    String selectedOption,
    bool status,
    List<String> optionList,
    Function onChange,
  ) {
    return status
        ? Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                DropdownButton(
                  value: selectedOption,
                  hint: Text(''),
                  items:
                      optionList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      child: Text(
                        value,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      value: value,
                    );
                  }).toList(),
                  onChanged: onChange,
                ),
              ],
            ),
          )
        : Container();
  }

  Future<List> getSelectedIntentionFactorSet() async {
    Provider.of<Login>(context, listen: false).getSelectedIntentionFactorSet();

    return Provider.of<Login>(context, listen: false)
        .selectedIntentionFactorSet;
  }

  void get_selectedIntentionFactorSet() async {
    await Provider.of<Login>(context, listen: false)
        .getSelectedIntentionFactorSet();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<Login>(context, listen: false).userData['userGroup'] ==
        'system-initiated') {
      return Consumer<Login>(builder: (context, login, child) {
        return login.selectedIntentionFactorSet == null
            ? Center(
                child: Text('請選擇一組傾向因素組合'),
              )
            : Expanded(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        buildIntentionFactorDropdownButton(
                          context,
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][0]['intentionFactorName'],
                          login.selectedIntentionFactorSet[0]
                                  ['intentionFactors'][0]
                              ['intentionFactorSelectedOption'],
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][0]['intentionFactorStatus'],
                          login.intentionFactor['intentionFactor'][0]
                                  ['intentionFactorOption']
                              .cast<String>(),
                          (value) {
                            setState(() {
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][0]
                                  ['intentionFactorSelectedOption'] = value;
                            });
                          },
                        ),
                        buildIntentionFactorDropdownButton(
                          context,
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][1]['intentionFactorName'],
                          login.selectedIntentionFactorSet[0]
                                  ['intentionFactors'][1]
                              ['intentionFactorSelectedOption'],
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][1]['intentionFactorStatus'],
                          login.intentionFactor['intentionFactor'][1]
                                  ['intentionFactorOption']
                              .cast<String>(),
                          (value) {
                            setState(() {
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][1]
                                  ['intentionFactorSelectedOption'] = value;
                            });
                          },
                        ),
                        buildIntentionFactorDropdownButton(
                          context,
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][2]['intentionFactorName'],
                          login.selectedIntentionFactorSet[0]
                                  ['intentionFactors'][2]
                              ['intentionFactorSelectedOption'],
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][2]['intentionFactorStatus'],
                          login.intentionFactor['intentionFactor'][2]
                                  ['intentionFactorOption']
                              .cast<String>(),
                          (value) {
                            setState(() {
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][2]
                                  ['intentionFactorSelectedOption'] = value;
                            });
                          },
                        ),
                        buildIntentionFactorDropdownButton(
                          context,
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][3]['intentionFactorName'],
                          login.selectedIntentionFactorSet[0]
                                  ['intentionFactors'][3]
                              ['intentionFactorSelectedOption'],
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][3]['intentionFactorStatus'],
                          login.intentionFactor['intentionFactor'][3]
                                  ['intentionFactorOption']
                              .cast<String>(),
                          (value) {
                            setState(() {
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][3]
                                  ['intentionFactorSelectedOption'] = value;
                            });
                          },
                        ),
                        buildIntentionFactorDropdownButton(
                          context,
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][4]['intentionFactorName'],
                          login.selectedIntentionFactorSet[0]
                                  ['intentionFactors'][4]
                              ['intentionFactorSelectedOption'],
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][4]['intentionFactorStatus'],
                          login.intentionFactor['intentionFactor'][4]
                                  ['intentionFactorOption']
                              .cast<String>(),
                          (value) {
                            setState(() {
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][4]
                                  ['intentionFactorSelectedOption'] = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
      });
    } else {
      return FutureBuilder(
        future: getSelectedIntentionFactorSet(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Consumer<Login>(builder: (context, login, child) {
            return login.selectedIntentionFactorSet == null
                ? Center(
                    child: Text('請選擇一組傾向因素組合'),
                  )
                : Expanded(
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            buildIntentionFactorDropdownButton(
                              context,
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][0]
                                  ['intentionFactorName'],
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][0]
                                  ['intentionFactorSelectedOption'],
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][0]
                                  ['intentionFactorStatus'],
                              login.intentionFactor['intentionFactor'][0]
                                      ['intentionFactorOption']
                                  .cast<String>(),
                              (value) {
                                setState(() {
                                  login.selectedIntentionFactorSet[0]
                                          ['intentionFactors'][0]
                                      ['intentionFactorSelectedOption'] = value;
                                });
                              },
                            ),
                            buildIntentionFactorDropdownButton(
                              context,
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][1]
                                  ['intentionFactorName'],
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][1]
                                  ['intentionFactorSelectedOption'],
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][1]
                                  ['intentionFactorStatus'],
                              login.intentionFactor['intentionFactor'][1]
                                      ['intentionFactorOption']
                                  .cast<String>(),
                              (value) {
                                setState(() {
                                  login.selectedIntentionFactorSet[0]
                                          ['intentionFactors'][1]
                                      ['intentionFactorSelectedOption'] = value;
                                });
                              },
                            ),
                            buildIntentionFactorDropdownButton(
                              context,
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][2]
                                  ['intentionFactorName'],
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][2]
                                  ['intentionFactorSelectedOption'],
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][2]
                                  ['intentionFactorStatus'],
                              login.intentionFactor['intentionFactor'][2]
                                      ['intentionFactorOption']
                                  .cast<String>(),
                              (value) {
                                setState(() {
                                  login.selectedIntentionFactorSet[0]
                                          ['intentionFactors'][2]
                                      ['intentionFactorSelectedOption'] = value;
                                });
                              },
                            ),
                            buildIntentionFactorDropdownButton(
                              context,
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][3]
                                  ['intentionFactorName'],
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][3]
                                  ['intentionFactorSelectedOption'],
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][3]
                                  ['intentionFactorStatus'],
                              login.intentionFactor['intentionFactor'][3]
                                      ['intentionFactorOption']
                                  .cast<String>(),
                              (value) {
                                setState(() {
                                  login.selectedIntentionFactorSet[0]
                                          ['intentionFactors'][3]
                                      ['intentionFactorSelectedOption'] = value;
                                });
                              },
                            ),
                            buildIntentionFactorDropdownButton(
                              context,
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][4]
                                  ['intentionFactorName'],
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][4]
                                  ['intentionFactorSelectedOption'],
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][4]
                                  ['intentionFactorStatus'],
                              login.intentionFactor['intentionFactor'][4]
                                      ['intentionFactorOption']
                                  .cast<String>(),
                              (value) {
                                setState(() {
                                  login.selectedIntentionFactorSet[0]
                                          ['intentionFactors'][4]
                                      ['intentionFactorSelectedOption'] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          });
        },
      );
    }
  }
}
