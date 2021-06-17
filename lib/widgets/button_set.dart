import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../screens/recommendation_screen.dart';
import '../provider/login.dart';

class ButtonSet extends StatefulWidget {
  @override
  _ButtonSetState createState() => _ButtonSetState();
}

class _ButtonSetState extends State<ButtonSet> {
  final saveInputController = TextEditingController();

  String cityName = 'Taipei';
  String weatherGoodBad;
  String dayNight;
  String weekdayWeekend;
  String currentContext;

  List intentionFactorStatusListBeforeEdit;
  List intentionFactorStatusListAfterEdit;

  @override
  initState() {
    intentionFactorStatusListAfterEdit = [];
    intentionFactorStatusListBeforeEdit = [];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
    if (Provider.of<Login>(context, listen: false).selectedIntentionFactorSet !=
        null) {
      print(
          'start     ${Provider.of<Login>(context, listen: false).selectedIntentionFactorSet}');
      CollectionReference usersEvent =
          FirebaseFirestore.instance.collection('usersEvent');
      usersEvent.doc('zqX5VRLQnFaAWkRLGt5Q').update({
        'usersEventRecord': FieldValue.arrayUnion([
          {
            'user': Provider.of<Login>(context, listen: false)
                .userData['userEmail'],
            'eventType': 'startRecommendation',
            'timeStamp': DateFormat.yMd().add_Hms().format(DateTime.now()),
          }
        ])
      });
      usersEvent
          .doc(Provider.of<Login>(context, listen: false).userData['userEmail'])
          .update({
        'usersEventRecord': FieldValue.arrayUnion([
          {
            'eventType': 'startRecommendation',
            'timeStamp': DateFormat.yMd().add_Hms().format(DateTime.now()),
          }
        ])
      });
      Navigator.of(context).pushNamed(RecommendationScreen.routeName);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: new Text('注意!!'),
              content: new Text('請選擇一個傾向因素組合'),
              actions: <Widget>[
                new TextButton(
                  child: new Text("確認"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  void startEdit(BuildContext context) {
    if (Provider.of<Login>(context, listen: false).selectedIntentionFactorSet !=
        null) {
      Provider.of<Login>(context, listen: false)
          .setIntentionFactorSetBeforeEdit(
              Provider.of<Login>(context, listen: false)
                  .selectedIntentionFactorSet);
      for (int i = 0; i < 5; i++) {
        intentionFactorStatusListBeforeEdit.add(
            Provider.of<Login>(context, listen: false)
                    .intentionFactorSetBeforeEdit[0]['intentionFactors'][i]
                ['intentionFactorStatus']);
      }
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return Consumer<Login>(
                builder: (context, login, child) {
                  return AlertDialog(
                    title: Text(
                      '編輯',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    content: Container(
                      width: MediaQuery.of(context).size.height * 0.8,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            buildContainer(
                              context,
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][0]
                                  ['intentionFactorName'],
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][0]
                                  ['intentionFactorStatus'],
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
                                      ['intentionFactors'][1]
                                  ['intentionFactorName'],
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][1]
                                  ['intentionFactorStatus'],
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
                                      ['intentionFactors'][2]
                                  ['intentionFactorName'],
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][2]
                                  ['intentionFactorStatus'],
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
                                      ['intentionFactors'][3]
                                  ['intentionFactorName'],
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][3]
                                  ['intentionFactorStatus'],
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
                                      ['intentionFactors'][4]
                                  ['intentionFactorName'],
                              login.selectedIntentionFactorSet[0]
                                      ['intentionFactors'][4]
                                  ['intentionFactorStatus'],
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
                    ),
                  );
                },
              );
            },
          );
        },
        barrierDismissible: false,
      );
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: new Text('注意!!'),
              content: new Text('請選擇一個傾向因素組合'),
              actions: <Widget>[
                new TextButton(
                  child: new Text("確認"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  void confirmEdit(BuildContext context) {
    Provider.of<Login>(context, listen: false).setIntentionFactorSetAfterEdit(
        Provider.of<Login>(context, listen: false).selectedIntentionFactorSet);
    for (int i = 0; i < 5; i++) {
      intentionFactorStatusListAfterEdit.add(
          Provider.of<Login>(context, listen: false)
                  .intentionFactorSetAfterEdit[0]['intentionFactors'][i]
              ['intentionFactorStatus']);
    }
    print('before $intentionFactorStatusListBeforeEdit');
    print('after $intentionFactorStatusListAfterEdit');
    Provider.of<Login>(context, listen: false).edit();

    int editIndexCount = 0;
    for (int i = 0; i < intentionFactorStatusListAfterEdit.length; i++) {
      if (intentionFactorStatusListBeforeEdit[i] !=
          intentionFactorStatusListAfterEdit[i]) {
        editIndexCount += 1;
        print(editIndexCount);
      }
    }
    print('editIndexCount $editIndexCount');
    CollectionReference usersEvent =
        FirebaseFirestore.instance.collection('usersEvent');
    usersEvent.doc('zqX5VRLQnFaAWkRLGt5Q').update({
      'usersEventRecord': FieldValue.arrayUnion([
        {
          'user':
              Provider.of<Login>(context, listen: false).userData['userEmail'],
          'eventType': 'confirmEdit',
          'editIndexCount': editIndexCount,
          'timeStamp': DateFormat.yMd().add_Hms().format(DateTime.now()),
        }
      ])
    });

    usersEvent
        .doc(Provider.of<Login>(context, listen: false).userData['userEmail'])
        .update({
      'usersEventRecord': FieldValue.arrayUnion([
        {
          'eventType': 'confirmEdit',
          'editIndexCount': editIndexCount,
          'timeStamp': DateFormat.yMd().add_Hms().format(DateTime.now()),
        }
      ])
    });
    Navigator.of(context).pop(context);
  }

  void startSave(BuildContext context) async {
    await getContext();
    if (Provider.of<Login>(context, listen: false).selectedIntentionFactorSet !=
        null) {
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
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
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
                                  usersEvent
                                      .doc('zqX5VRLQnFaAWkRLGt5Q')
                                      .update({
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
                                  usersEvent
                                      .doc(Provider.of<Login>(context,
                                              listen: false)
                                          .userData['userEmail'])
                                      .update({
                                    'usersEventRecord': FieldValue.arrayUnion([
                                      {
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
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: new Text('注意!!'),
              content: new Text('請選擇一個傾向因素組合'),
              actions: <Widget>[
                new TextButton(
                  child: new Text("確認"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  Future getContext() async {
    currentContext = Provider.of<Login>(context, listen: false).currentContext;
  }

  void confirmSave() async {
    if (saveInputController.text.isEmpty) {}
    if (saveInputController.text.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      var path = prefs.getString('userEmail');

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

      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      users.doc(path).update({
        'userIntentionFactorSets': FieldValue.arrayUnion([
          Provider.of<Login>(context, listen: false)
              .selectedIntentionFactorSet[0]
        ])
      });

      await Provider.of<Login>(context, listen: false)
          .resetSelectedIntentionFactorSetName(saveInputController.text);
      Provider.of<Login>(context, listen: false).save();
      Navigator.of(context).pop(context);
      saveInputController.clear();

      CollectionReference usersEvent =
          FirebaseFirestore.instance.collection('usersEvent');
      usersEvent.doc('zqX5VRLQnFaAWkRLGt5Q').update(
        {
          'usersEventRecord': FieldValue.arrayUnion(
            [
              {
                'user': Provider.of<Login>(context, listen: false)
                    .userData['userEmail'],
                'eventType': 'confirmSave',
                'timeStamp': DateFormat.yMd().add_Hms().format(DateTime.now()),
              }
            ],
          )
        },
      );
      usersEvent
          .doc(Provider.of<Login>(context, listen: false).userData['userEmail'])
          .update({
        'usersEventRecord': FieldValue.arrayUnion([
          {
            'eventType': 'confirmSave',
            'timeStamp': DateFormat.yMd().add_Hms().format(DateTime.now()),
          }
        ])
      });
    }
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
                buildTextButton(context, '編輯', () => startEdit(context)),
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
                buildTextButton(context, '儲存', () => {startSave(context)}),
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
            buildTextButton(context, '開始', () => startRecommendation(context)),
            SizedBox(
              width: 5,
            ),
          ],
        )),
      ],
    );
  }
}
