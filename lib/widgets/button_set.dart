import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';

import '../screens/recommendation_screen.dart';
import '../provider/login.dart';

class ButtonSet extends StatefulWidget {
  @override
  _ButtonSetState createState() => _ButtonSetState();
}

class _ButtonSetState extends State<ButtonSet> {
  // bool loadInitiatedFactorStatus = false;
  // List<dynamic> intentionFactorSetForCancel;
  final saveInputController = TextEditingController();

  // WeatherFactory wf = new WeatherFactory('58dbf39967ed6036991d250caabcf477',
  //     language: Language.CHINESE_TRADITIONAL);
  String cityName = 'Taipei';
  String weatherGoodBad;
  String dayNight;
  String weekdayWeekend;
  String currentContext;

  @override
  initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // if (loadInitiatedFactorStatus == false) {
    // intentionFactorSetForCancel = List.from(
    //     Provider.of<Login>(context, listen: false)
    //         .userData['userIntentionFactorSets']);
    // intentionFactorSetForEdit = List.from(
    //     Provider.of<Login>(context, listen: false)
    //         .userData['userIntentionFactorSets']);
    // print('$intentionFactorSetForCancel  for cancel');
    // print('$intentionFactorSetForEdit  for edit');
    //   intentionFactorSetForCancel = Provider.of<Login>(context, listen: false)
    //       .userData['userIntentionFactorSets'];
    //   loadInitiatedFactorStatus = true;
    // }
  }

  Widget buildTextButton(BuildContext context, String label, Function onpress) {
    return Expanded(
      child: TextButton(
        onPressed: onpress,
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.yellow.shade600),
        ),
      ),
    );
  }

  Widget buildContainer(
      BuildContext context, String title, bool status, Function onchange) {
    return Container(
      child: CheckboxListTile(
        title: Text(title),
        value: status,
        onChanged: onchange,
      ),
    );
  }

  void startRecommendation(BuildContext context) {
    CollectionReference usersEvent =
        FirebaseFirestore.instance.collection('usersEvent');
    usersEvent.doc('6Kme8kTW8NvQwWYw5uVT').update({
      'usersEventRecord': FieldValue.arrayUnion([
        {
          'user':
              Provider.of<Login>(context, listen: false).userData['userEmail'],
          'eventType': 'startRecommendation',
          'timeStamp': DateFormat.yMd().add_Hms().format(DateTime.now()),
        }
      ])
    });
    Navigator.of(context).pushNamed(RecommendationScreen.routeName);
    // print((Provider.of<Login>(context, listen: false)
    //     .userData['userIntentionFactorSets']));
  }

  void startEdit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return Consumer<Login>(
              builder: (context, login, child) {
                // print('$intentionFactorSetForCancel aaa');
                // print('${login.userData['userIntentionFactorSets']}  bbb');
                return AlertDialog(
                  title: Text(
                    '編輯',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  content: Container(
                    width: MediaQuery.of(context).size.height * 0.8,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      children: <Widget>[
                        buildContainer(
                          context,
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][0]['intentionFactorName'],
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][0]['intentionFactorStatus'],
                          (bool) {
                            setState(
                              () {
                                login.changeStatusAndSelected(0, bool);
                              },
                            );
                          },
                        ),
                        buildContainer(
                          context,
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][1]['intentionFactorName'],
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][1]['intentionFactorStatus'],
                          (bool) {
                            setState(
                              () {
                                login.changeStatusAndSelected(1, bool);
                              },
                            );
                          },
                        ),
                        buildContainer(
                          context,
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][2]['intentionFactorName'],
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][2]['intentionFactorStatus'],
                          (bool) {
                            setState(
                              () {
                                login.changeStatusAndSelected(2, bool);
                              },
                            );
                          },
                        ),
                        buildContainer(
                          context,
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][3]['intentionFactorName'],
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][3]['intentionFactorStatus'],
                          (bool) {
                            setState(
                              () {
                                login.changeStatusAndSelected(3, bool);
                              },
                            );
                          },
                        ),
                        buildContainer(
                          context,
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][4]['intentionFactorName'],
                          login.selectedIntentionFactorSet[0]
                              ['intentionFactors'][4]['intentionFactorStatus'],
                          (bool) {
                            setState(
                              () {
                                login.changeStatusAndSelected(4, bool);
                              },
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            buildTextButton(
                                context, '確定', () => confirmEdit(context)),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      barrierDismissible: false,
    );
  }

  // void cancelEdit(BuildContext context) {
  //   Navigator.of(context).pop();
  // }

  void confirmEdit(BuildContext context) {
    Provider.of<Login>(context, listen: false).edit();
    CollectionReference usersEvent =
        FirebaseFirestore.instance.collection('usersEvent');
    usersEvent.doc('6Kme8kTW8NvQwWYw5uVT').update({
      'usersEventRecord': FieldValue.arrayUnion([
        {
          'user':
              Provider.of<Login>(context, listen: false).userData['userEmail'],
          'eventType': 'confirmEdit',
          'timeStamp': DateFormat.yMd().add_Hms().format(DateTime.now()),
        }
      ])
    });
    Navigator.of(context).pop(context);
  }

  void startSave(BuildContext context) async {
    await getContext();
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return Consumer<Login>(
              builder: (context, login, child) {
                return AlertDialog(
                  title: Text(
                    '儲存',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  content: Container(
                    width: MediaQuery.of(context).size.height * 0.8,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '請輸入組合名稱',
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                            ),
                            controller: saveInputController,
                          ),
                          Container(
                            child: ListTile(
                              title: Text(
                                '情境',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              trailing: Text(
                                login.currentContext,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                          Container(
                            child: ListTile(
                              title: Text(
                                '${login.selectedIntentionFactorSet[0]['intentionFactors'][0]['intentionFactorName']}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              subtitle: Text(
                                '${login.selectedIntentionFactorSet[0]['intentionFactors'][0]['intentionFactorStatus']}',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              trailing: Text(
                                '${login.selectedIntentionFactorSet[0]['intentionFactors'][0]['intentionFactorSelectedOption']}',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                          Container(
                            child: ListTile(
                              title: Text(
                                '${login.selectedIntentionFactorSet[0]['intentionFactors'][1]['intentionFactorName']}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              subtitle: Text(
                                '${login.selectedIntentionFactorSet[0]['intentionFactors'][1]['intentionFactorStatus']}',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              trailing: Text(
                                '${login.selectedIntentionFactorSet[0]['intentionFactors'][1]['intentionFactorSelectedOption']}',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                          Container(
                            child: ListTile(
                              title: Text(
                                '${login.selectedIntentionFactorSet[0]['intentionFactors'][2]['intentionFactorName']}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              subtitle: Text(
                                '${login.selectedIntentionFactorSet[0]['intentionFactors'][2]['intentionFactorStatus']}',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              trailing: Text(
                                '${login.selectedIntentionFactorSet[0]['intentionFactors'][2]['intentionFactorSelectedOption']}',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                          Container(
                            child: ListTile(
                              title: Text(
                                '${login.selectedIntentionFactorSet[0]['intentionFactors'][3]['intentionFactorName']}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              subtitle: Text(
                                '${login.selectedIntentionFactorSet[0]['intentionFactors'][3]['intentionFactorStatus']}',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              trailing: Text(
                                '${login.selectedIntentionFactorSet[0]['intentionFactors'][3]['intentionFactorSelectedOption']}',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                          Container(
                            child: ListTile(
                              title: Text(
                                '${login.selectedIntentionFactorSet[0]['intentionFactors'][4]['intentionFactorName']}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              subtitle: Text(
                                '${login.selectedIntentionFactorSet[0]['intentionFactors'][4]['intentionFactorStatus']}',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              trailing: Text(
                                '${login.selectedIntentionFactorSet[0]['intentionFactors'][4]['intentionFactorSelectedOption']}',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              buildTextButton(context, '取消', () {
                                Navigator.of(context).pop(context);
                                CollectionReference usersEvent =
                                    FirebaseFirestore.instance
                                        .collection('usersEvent');
                                usersEvent.doc('6Kme8kTW8NvQwWYw5uVT').update({
                                  'usersEventRecord': FieldValue.arrayUnion([
                                    {
                                      'user': Provider.of<Login>(context,
                                              listen: false)
                                          .userData['userEmail'],
                                      'eventType': 'cancelSave',
                                      'timeStamp': DateFormat.yMd()
                                          .add_Hms()
                                          .format(DateTime.now()),
                                    }
                                  ])
                                });
                              }),
                              SizedBox(
                                width: 20,
                              ),
                              buildTextButton(context, '儲存', confirmSave),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      barrierDismissible: false,
    );
  }

  Future getContext() async {
    // Weather w = await wf.currentWeatherByCityName(cityName);
    // final weather = w.weatherMain;
    // if (weather == 'Thunderstorm' ||
    //     weather == 'Drizzle' ||
    //     weather == 'Rain') {
    //   weatherGoodBad = 'bad';
    // } else {
    //   weatherGoodBad = 'good';
    // }

    // final day = DateFormat.E().format(DateTime.now());
    // if (day == 'Sat' || day == 'Sun') {
    //   weekdayWeekend = 'weekend';
    // } else {
    //   weekdayWeekend = 'weekday';
    // }

    // final time = DateFormat.H().format(DateTime.now());
    // if (int.parse(time) < 18) {
    //   dayNight = 'day';
    // } else {
    //   dayNight = 'night';
    // }
    // currentContext = '$weatherGoodBad$weekdayWeekend$dayNight';
    // print(weather);
    // print(weekdayWeekend);
    // print(dayNight);
    currentContext = Provider.of<Login>(context, listen: false).currentContext;
  }

  void confirmSave() async {
    final prefs = await SharedPreferences.getInstance();
    var path = prefs.getString('userEmail');
    // Provider.of<Login>(context, listen: false)
    //     .userData['userIntentionFactorSets']
    //     .last['userIntentionFactorSetName'] = saveInputController.text;
    // Provider.of<Login>(context, listen: false)
    //     .userData['userIntentionFactorSets']
    //     .last['userIntentionFactorSetContext'] = currentContext;
    if (Provider.of<Login>(context, listen: false)
        .fitContextIntentionFactorSetsName
        .contains(saveInputController.text)) {
      saveInputController.text = saveInputController.text +
          '-' +
          DateFormat.Hms().format(DateTime.now()) +
          '-' +
          DateFormat.Md().format(DateTime.now());
    }
    Provider.of<Login>(context, listen: false).selectedIntentionFactorSet[0]
        ['userIntentionFactorSetName'] = saveInputController.text;
    Provider.of<Login>(context, listen: false).selectedIntentionFactorSet[0]
        ['userIntentionFactorSetContext'] = currentContext;
    // Provider.of<Login>(context, listen: false).selectedIntentionFactorSetName =
    //     saveInputController.text;

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    users.doc(path).update({
      'userIntentionFactorSets': FieldValue.arrayUnion([
        // Provider.of<Login>(context, listen: false)
        //     .userData['userIntentionFactorSets']
        //     .last
        Provider.of<Login>(context, listen: false).selectedIntentionFactorSet[0]
      ])
    });

    await Provider.of<Login>(context, listen: false)
        .resetSelectedIntentionFactorSetName(saveInputController.text);
    Provider.of<Login>(context, listen: false).save();
    Navigator.of(context).pop(context);
    saveInputController.clear();

    CollectionReference usersEvent =
        FirebaseFirestore.instance.collection('usersEvent');
    usersEvent.doc('6Kme8kTW8NvQwWYw5uVT').update({
      'usersEventRecord': FieldValue.arrayUnion([
        {
          'user':
              Provider.of<Login>(context, listen: false).userData['userEmail'],
          'eventType': 'confirmSave',
          'timeStamp': DateFormat.yMd().add_Hms().format(DateTime.now()),
        }
      ])
    });
    // getContext();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if ((Provider.of<Login>(context, listen: false)
                    .userData['userGroup']) ==
                'mix-initiated' ||
            (Provider.of<Login>(context, listen: false)
                    .userData['userGroup']) ==
                'user-initiated')
          Expanded(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 5,
                ),
                buildTextButton(context, 'edit', () => startEdit(context)),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        if ((Provider.of<Login>(context, listen: false)
                    .userData['userGroup']) ==
                'mix-initiated' ||
            (Provider.of<Login>(context, listen: false)
                    .userData['userGroup']) ==
                'user-initiated')
          Expanded(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 5,
                ),
                buildTextButton(context, 'save', () => {startSave(context)}),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        Expanded(
            child: Row(
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            buildTextButton(
                context, 'start', () => startRecommendation(context)),
            SizedBox(
              width: 5,
            ),
          ],
        )),
      ],
    );
  }
}
