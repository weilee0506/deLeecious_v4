import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

import 'dart:math';
import 'dart:async';

import '../provider/login.dart';

class RecommendationScreen extends StatefulWidget {
  static const routeName = '/recommendation-screen';

  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  List<Map> candidateList;
  List<Map> candidateListFilterPreference;
  List<Map> candidateListFilterTime;
  List<Map> candidateListFilterDistance;
  List<Map> candidateListFilterRating;
  List<Map> resultList;

  StreamController<double> controller = StreamController<double>();

  @override
  void initState() {
    candidateList = [];
    candidateListFilterPreference = [];
    candidateListFilterTime = [];
    candidateListFilterDistance = [];
    candidateListFilterRating = [];
    resultList = [];
    super.initState();
  }

  Stream<QuerySnapshot> getRecommendation(
    String service,
    String consumption,
    // String time,
    // String distance,
  ) {
    Query restaurants = FirebaseFirestore.instance.collection('restaurants');

    if (service != '不考慮') {
      restaurants = restaurants.where('inout', arrayContains: service);
    }
    if (consumption != '不考慮') {
      switch (consumption) {
        case '\$':
          consumption = 'p';
          break;
        case '\$\$':
          consumption = 'pp';
          break;
        case '\$\$\$':
          consumption = 'ppp';
          break;
        case '\$\$\$\$':
          consumption = 'pppp';
          break;
      }
      restaurants = restaurants.where('price_segment', isEqualTo: consumption);
    }
    // if (rating != '不考慮') {
    //   restaurants = restaurants.where('rating', isGreaterThan: 4);
    // }
    // print(restaurants.orderBy('rating', descending: true).limit(20).get());
    // restaurants
    //     .orderBy('rating', descending: true)
    //     .limit(20)
    //     .get()
    //     .then((value) {
    //   value.docs.forEach((element) {
    //     candidateList.add(element.data());
    //     // print(element.data());
    //   });
    //   print('aaa ${value.docs}');
    //   print('bbb ${value.docs.length}');
    // });

    return restaurants
        .orderBy('rating', descending: true)
        .limit(100)
        .snapshots();
  }

  List calculatePreference(
    AsyncSnapshot snapshot,
    List preferenceList,
    String timeSelectedOption,
    String distanceSelectedOption,
    String ratingSelectedOption,
  ) {
    // print(preferenceList);
    snapshot.data.docs.forEach((element) {
      candidateList.add(element.data());
    });
    List cuisineTypeList = [
      '台式',
      '中式',
      '韓式',
      '港式',
      '泰式',
      '越式',
      '義式',
      '法式',
      '美式',
      '德式',
      '歐式',
      '東南亞',
      '日式',
      '印式',
      '墨式',
      '俄式',
      '中東式',
      '夏威夷式',
      '飲料',
      '咖啡',
      '酒吧/餐酒館'
    ];
    candidateList.forEach((element) {
      List cuisineList = [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
      ];
      //餐廳cuisine轉成陣列
      for (int i = 0; i < cuisineTypeList.length; i++) {
        if (element['cuisine_type'].contains(cuisineTypeList[i])) {
          cuisineList[i] = 1;
        }
      }
      //餐廳cuisine陣列加到candidateList裡面
      element['cuisineList'] = cuisineList;
      //算每個餐廳跟user的cosSimilarity，再加到candidateList裡面
      element['cosSimilarity'] =
          preferenceAlgo(preferenceList, element['cuisineList']);
      // print('111  $cuisineList');
      // print(element);
    });
    candidateList
        .sort((a, b) => (b['cosSimilarity']).compareTo(a['cosSimilarity']));
    candidateListFilterPreference = candidateList
        .where((element) => element['cosSimilarity'] != 0)
        .toList();

    candidateListFilterPreference.forEach((element) {
      double distance = calculateDistance(
          element['lat'],
          element['lng'],
          Provider.of<Login>(context, listen: false).currentLocation.latitude,
          Provider.of<Login>(context, listen: false).currentLocation.longitude);
      element['distance'] = distance.toStringAsFixed(2);
    });

    if (timeSelectedOption == '不考慮') {
      candidateListFilterPreference.forEach((element) {
        candidateListFilterTime.add(element);
      });
    }
    if (timeSelectedOption == '少於30分鐘') {
      candidateListFilterPreference.forEach((element) {
        if (double.parse(element['distance']) < 0.5) {
          candidateListFilterTime.add(element);
        }
      });
    }
    if (timeSelectedOption == '30分鐘至2小時') {
      candidateListFilterPreference.forEach((element) {
        if (double.parse(element['distance']) > 0.5 &&
            double.parse(element['distance']) < 2) {
          candidateListFilterTime.add(element);
        }
      });
    }
    if (candidateListFilterTime.length != 0) {
      if (distanceSelectedOption == '不考慮') {
        candidateListFilterTime.forEach((element) {
          candidateListFilterDistance.add(element);
        });
      }
      if (distanceSelectedOption == '少於500公尺') {
        candidateListFilterTime.forEach((element) {
          if (double.parse(element['distance']) < 0.5) {
            candidateListFilterDistance.add(element);
          }
        });
      }
      if (distanceSelectedOption == '500至2000公尺') {
        candidateListFilterTime.forEach((element) {
          if (double.parse(element['distance']) > 0.5 &&
              double.parse(element['distance']) < 2) {
            candidateListFilterDistance.add(element);
          }
        });
      }
    }

    if (candidateListFilterDistance.length != 0) {
      if (ratingSelectedOption == '不考慮') {
        candidateListFilterDistance.forEach((element) {
          candidateListFilterRating.add(element);
        });
      }
      if (ratingSelectedOption == '四顆星以上') {
        candidateListFilterDistance
            .sort((a, b) => (b['rating']).compareTo(a['rating']));
        candidateListFilterDistance.forEach((element) {
          candidateListFilterRating.add(element);
        });
      }
    }

    if (candidateListFilterRating.length != 0) {
      if (candidateListFilterRating.length < 10) {
        for (int i = 0; i < candidateListFilterRating.length - 1; i++) {
          resultList.add(candidateListFilterRating[i]);
        }
      } else {
        for (int i = 0; i < 10; i++) {
          resultList.add(candidateListFilterRating[i]);
        }
      }
    }

    // print(candidateList.length);
    // print(candidateListFilterPreference.length);
    // print(candidateListFilterTime.length);

    // print(candidateListFilterDistance.length);
    // print(candidateListFilterRating.length);

    // print(resultList.length);
  }

  double preferenceAlgo(List preferenceList, List cuisineList) {
    double PiFi = 0;
    double Pi2 = 0;
    double Fi2 = 0;
    double cosSimilarity;
    for (int i = 0; i < preferenceList.length; i++) {
      PiFi += preferenceList[i] * cuisineList[i];
    }
    for (int i = 0; i < preferenceList.length; i++) {
      Pi2 += pow(preferenceList[i], 2);
    }
    Pi2 = sqrt(Pi2);
    for (int i = 0; i < cuisineList.length; i++) {
      Fi2 += pow(cuisineList[i], 2);
    }
    Fi2 = sqrt(Fi2);
    cosSimilarity = PiFi / (Pi2 * Fi2);
    return cosSimilarity;
  }

  Future<void> selectRestaurant(
    String userEmail,
    String selectedRestaurant,
    String selectedService,
    String selectedConsumption,
    String selectedTime,
    String selectedDistance,
    String selectedRating,
    List restaurantCuisineList,
  ) async {
    // CollectionReference usersSelect =
    //     FirebaseFirestore.instance.collection('usersSelect');
    // usersSelect.add({
    //   'user': userEmail,
    //   'restautant': selectedRestaurant,
    //   'timeStamp': DateFormat.yMd().add_Hms().format(DateTime.now()),
    //   'service': selectedService,
    //   'consumption': selectedConsumption,
    //   'time': selectedTime,
    //   'distance': selectedDistance,
    //   'rating': selectedRating,
    // });
    CollectionReference usersSelect =
        FirebaseFirestore.instance.collection('usersSelect');
    usersSelect.doc('WMMjsjcVadtZAzWsid3c').update({
      'usersSelectRecord': FieldValue.arrayUnion([
        {
          'user': userEmail,
          'restautant': selectedRestaurant,
          'timeStamp': DateFormat.yMd().add_Hms().format(DateTime.now()),
          'service': selectedService,
          'consumption': selectedConsumption,
          'time': selectedTime,
          'distance': selectedDistance,
          'rating': selectedRating,
        }
      ])
    });

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    List userPreference =
        Provider.of<Login>(context, listen: false).userData['userPreference'];
    for (int i = 0; i < 21; i++) {
      userPreference[i] += restaurantCuisineList[i];
    }
    users
        .doc(Provider.of<Login>(context, listen: false).userData['userEmail'])
        .update({'userPreference': userPreference});

    CollectionReference usersEvent =
        FirebaseFirestore.instance.collection('usersEvent');
    usersEvent.doc('6Kme8kTW8NvQwWYw5uVT').update({
      'usersEventRecord': FieldValue.arrayUnion([
        {
          'user':
              Provider.of<Login>(context, listen: false).userData['userEmail'],
          'eventType': 'selectRestaurant',
          'timeStamp': DateFormat.yMd().add_Hms().format(DateTime.now()),
        }
      ])
    });

    // Provider.of<Login>(context, listen: false).setEndTime(
    //     DateFormat.H().format(DateTime.now()),
    //     DateFormat.m().format(DateTime.now()),
    //     DateFormat.s().format(DateTime.now()));
    // int hour = int.parse(DateFormat.H().format(DateTime.now())) -
    //     int.parse(Provider.of<Login>(context, listen: false).startTime[0]);
    // int minute = int.parse(DateFormat.m().format(DateTime.now())) -
    //     int.parse(Provider.of<Login>(context, listen: false).startTime[1]);
    // int second = int.parse(DateFormat.s().format(DateTime.now())) -
    //     int.parse(Provider.of<Login>(context, listen: false).startTime[2]);

    int startSeconds =
        int.parse(Provider.of<Login>(context, listen: false).startTime[0]) *
                3600 +
            int.parse(Provider.of<Login>(context, listen: false).startTime[1]) *
                60 +
            int.parse(Provider.of<Login>(context, listen: false).startTime[2]);
    int endSeconds = int.parse(DateFormat.H().format(DateTime.now())) * 3600 +
        int.parse(DateFormat.m().format(DateTime.now())) * 60 +
        int.parse(DateFormat.s().format(DateTime.now()));
    int executeSeconds = endSeconds - startSeconds;

    usersEvent.doc('6Kme8kTW8NvQwWYw5uVT').update({
      'usersEventRecord': FieldValue.arrayUnion([
        {
          'user':
              Provider.of<Login>(context, listen: false).userData['userEmail'],
          'eventType': 'finishOneRecommendation',
          'startTime': Provider.of<Login>(context, listen: false).startTime,
          'endTime': [
            DateFormat.H().format(DateTime.now()),
            DateFormat.m().format(DateTime.now()),
            DateFormat.s().format(DateTime.now())
          ],
          'executeTime': executeSeconds,
          'timeStamp': DateFormat.yMd().add_Hms().format(DateTime.now()),
        }
      ])
    });
    Provider.of<Login>(context, listen: false).setStartTime(
        DateFormat.H().format(DateTime.now()),
        DateFormat.m().format(DateTime.now()),
        DateFormat.s().format(DateTime.now()));

    // CollectionReference usersEvent =
    //     FirebaseFirestore.instance.collection('usersEvent');

    Navigator.of(context).pop(context);
  }

  Widget resultItem(
      BuildContext context,
      String name,
      String address,
      String cuisine,
      List service,
      String consumption,
      String time,
      String distance,
      double rating,
      String userEmail,
      String selectedService,
      String selectedConsumption,
      String selectedTime,
      String selectedDistance,
      String selectedRating,
      List restaurantCuisineList) {
    if (consumption == 'p') {
      consumption = '150元以下';
    }
    if (consumption == 'pp') {
      consumption = '150-600元';
    }
    if (consumption == 'ppp') {
      consumption = '600-1200元';
    }
    if (consumption == 'pppp') {
      consumption = '1200元以上';
    }
    return Container(
      // onTap: () {},
      // borderRadius: BorderRadius.circular(15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                name,
                style: Theme.of(context).textTheme.headline4,
              ),
              subtitle: Text(
                address,
                style: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                  fontSize: 15,
                  fontFamily: 'RobotoCondensed',
                ),
              ),
              trailing: Text(
                cuisine,
                style: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                  fontSize: 15,
                  fontFamily: 'RobotoCondensed',
                ),
              ),
            ),
            Divider(),
            ListTile(
              title: Text('服務'),
              trailing: Text(service.join()),
            ),
            ListTile(
              title: Text('均消'),
              trailing: Text(consumption),
            ),
            ListTile(
              title: Text('時間'),
              trailing: Text(time),
            ),
            ListTile(
              title: Text('距離'),
              trailing: Text('$distance 公里'),
            ),
            ListTile(
              title: Text('評分'),
              trailing: Text('$rating'),
            ),
            Divider(),
            Container(
              width: double.infinity,
              child: TextButton(
                onPressed: () async {
                  await Firebase.initializeApp();
                  selectRestaurant(
                    userEmail,
                    name,
                    selectedService,
                    selectedConsumption,
                    selectedDistance,
                    selectedTime,
                    selectedRating,
                    restaurantCuisineList,
                  );
                },
                child: Text(
                  '選擇餐廳',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  // void _getCurrentLocation() {
  //   Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.best,
  //           forceAndroidLocationManager: true)
  //       .then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //     });
  //   }).catchError((e) {
  //     print(e);
  //   });
  //   print(_currentPosition);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('recommendation'),
      ),
      body: Consumer<Login>(
        builder: (context, login, child) {
          return StreamBuilder(
            stream: getRecommendation(
              login.selectedIntentionFactorSet[0]['intentionFactors'][0]
                  ['intentionFactorSelectedOption'],
              login.selectedIntentionFactorSet[0]['intentionFactors'][1]
                  ['intentionFactorSelectedOption'],
              // time,
              // login.selectedIntentionFactorSet[0]['intentionFactors'][3]
              //     ['intentionFactorSelectedOption'],
            ),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                calculatePreference(
                  snapshot,
                  login.userData['userPreference'],
                  login.selectedIntentionFactorSet[0]['intentionFactors'][2]
                      ['intentionFactorSelectedOption'],
                  login.selectedIntentionFactorSet[0]['intentionFactors'][3]
                      ['intentionFactorSelectedOption'],
                  login.selectedIntentionFactorSet[0]['intentionFactors'][4]
                      ['intentionFactorSelectedOption'],
                );
                return (resultList.length == 0)
                    ? Center(
                        child: Text('get 0 result'),
                      )
                    : Scrollbar(
                        child: ListView.builder(
                          itemBuilder: (ctx, index) {
                            return resultItem(
                                ctx,
                                resultList[index]['name'],
                                resultList[index]['address'],
                                resultList[index]['cuisine_type'],
                                resultList[index]['inout'],
                                resultList[index]['price_segment'],
                                login.selectedIntentionFactorSet[0]
                                        ['intentionFactors'][2]
                                    ['intentionFactorSelectedOption'],
                                resultList[index]['distance'],
                                resultList[index]['rating'],
                                login.userData['userEmail'],
                                login.selectedIntentionFactorSet[0]
                                        ['intentionFactors'][0]
                                    ['intentionFactorSelectedOption'],
                                login.selectedIntentionFactorSet[0]
                                        ['intentionFactors'][1]
                                    ['intentionFactorSelectedOption'],
                                login.selectedIntentionFactorSet[0]
                                        ['intentionFactors'][2]
                                    ['intentionFactorSelectedOption'],
                                login.selectedIntentionFactorSet[0]
                                        ['intentionFactors'][3]
                                    ['intentionFactorSelectedOption'],
                                login.selectedIntentionFactorSet[0]
                                        ['intentionFactors'][4]
                                    ['intentionFactorSelectedOption'],
                                resultList[index]['cuisineList']);
                          },
                          // itemCount: snapshot.data.docs.length,/
                          itemCount: resultList.length,
                        ),
                      );
              } else {
                return Center(
                  child: Text('waiting'),
                );
              }
            },
          );
        },
      ),
    );
  }
}
