import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<Map> candidateListFilterService;
  List<Map> candidateListFilterConsumption;

  List<Map> dataList;
  List<Map> resultList;
  bool isLoading;
  bool isReady;

  int randomPositionGroup;
  double currentLat;
  double currentLon;

  CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');

  Random random = new Random();

  @override
  void initState() {
    super.initState();

    candidateList = [];
    candidateListFilterPreference = [];
    candidateListFilterTime = [];
    candidateListFilterDistance = [];
    candidateListFilterRating = [];
    candidateListFilterService = [];
    candidateListFilterConsumption = [];

    dataList = [];

    resultList = [];
    isLoading = true;
    isReady = false;

    currentLat = 0;
    currentLon = 0;
    randomPositionGroup = random.nextInt(3) + 1;

    getData();
  }

  Future<void> getData() async {
    //文山區
    if (randomPositionGroup == 1) {
      currentLat = (random.nextInt(29870) + 24979953) / 1000000;
      currentLon = (random.nextInt(59750) + 121530150) / 1000000;
    }
    //大安區
    if (randomPositionGroup == 2) {
      currentLat = (random.nextInt(36148) + 25008990) / 1000000;
      currentLon = (random.nextInt(25136) + 121532736) / 1000000;
    }
    //信義區
    if (randomPositionGroup == 3) {
      currentLat = (random.nextInt(14615) + 25030122) / 1000000;
      currentLon = (random.nextInt(20017) + 121560049) / 1000000;
    }
    print('currentLocaiton  $currentLat  $currentLon');
    Map<String, dynamic> restaurantData;
    CollectionReference restaurants =
        FirebaseFirestore.instance.collection('restaurants');
    restaurants.get().then(
      (querySnapshot) {
        querySnapshot.docs.forEach((result) async {
          restaurantData = Map<String, dynamic>.from(result.data());
          this.dataList.add(restaurantData);
        });
        this.calculatePreference(
          currentLat,
          currentLon,
          this.dataList,
          Provider.of<Login>(context, listen: false)
                  .selectedIntentionFactorSet[0]['intentionFactors'][0]
              ['intentionFactorSelectedOption'],
          Provider.of<Login>(context, listen: false)
                  .selectedIntentionFactorSet[0]['intentionFactors'][1]
              ['intentionFactorSelectedOption'],
          Provider.of<Login>(context, listen: false).userData['userPreference'],
          Provider.of<Login>(context, listen: false)
                  .selectedIntentionFactorSet[0]['intentionFactors'][2]
              ['intentionFactorSelectedOption'],
          Provider.of<Login>(context, listen: false)
                  .selectedIntentionFactorSet[0]['intentionFactors'][3]
              ['intentionFactorSelectedOption'],
          Provider.of<Login>(context, listen: false)
                  .selectedIntentionFactorSet[0]['intentionFactors'][4]
              ['intentionFactorSelectedOption'],
        );
        this.isLoading = false;

        setState(() {});
      },
    );

    return dataList;
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

    return restaurants
        .orderBy('rating', descending: true)
        .limit(100)
        .snapshots();
  }

  Future<void> calculatePreference(
    double lat,
    double lon,
    List dataList,
    String serviceSelectedOption,
    String consumptionSelectedOption,
    List preferenceList,
    String timeSelectedOption,
    String distanceSelectedOption,
    String ratingSelectedOption,
  ) {
    print('candidateList     $dataList');
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
      '餐酒館/酒吧'
    ];
    List restaurantCuisineList = [];
    List restaurantCosSimilarityList = [];
    this.dataList.forEach((element) {
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
      restaurantCuisineList.add(cuisineList);
    });
    print(restaurantCuisineList);

    for (int i = 0; i < this.dataList.length; i++) {
      //餐廳cuisine陣列加到candidateList裡面
      this
          .dataList[i]
          .putIfAbsent('cuisineList', () => restaurantCuisineList[i]);

      //算每個餐廳跟user的cosSimilarity
      double cosSimilarity =
          this.preferenceAlgo(preferenceList, dataList[i]['cuisineList']);
      restaurantCosSimilarityList.add(cosSimilarity);
      //餐廳跟user的cosSimilarity加到candidateList裡面

      this
          .dataList[i]
          .putIfAbsent('cosSimilarity', () => restaurantCosSimilarityList[i]);
    }
    print(restaurantCosSimilarityList);

    this
        .dataList
        .sort((a, b) => (b['cosSimilarity']).compareTo(a['cosSimilarity']));

    this.candidateListFilterPreference = this
        .dataList
        .where((element) => element['cosSimilarity'] != 0)
        .toList();

    this.candidateListFilterPreference.forEach((element) {
      double distance =
          this.calculateDistance(element['lat'], element['lng'], lat, lon);
      element['distance'] = distance.toStringAsFixed(2);
    });

    print(randomPositionGroup);
    print(candidateListFilterPreference);

    if (timeSelectedOption == '不考慮') {
      this.candidateListFilterPreference.forEach((element) {
        this.candidateListFilterTime.add(element);
      });
    }

    if (timeSelectedOption == '少於30分鐘') {
      this.candidateListFilterPreference.forEach((element) {
        if (double.parse(element['distance']) < 0.5) {
          this.candidateListFilterTime.add(element);
        }
      });
    }

    if (timeSelectedOption == '30分鐘至2小時') {
      this.candidateListFilterPreference.forEach((element) {
        if (double.parse(element['distance']) > 0.5 &&
            double.parse(element['distance']) < 2) {
          this.candidateListFilterTime.add(element);
        }
      });
    }

    if (this.candidateListFilterTime.length != 0) {
      if (distanceSelectedOption == '不考慮') {
        this.candidateListFilterTime.forEach((element) {
          this.candidateListFilterDistance.add(element);
        });
      }

      if (distanceSelectedOption == '少於500公尺') {
        this.candidateListFilterTime.forEach((element) {
          if (double.parse(element['distance']) < 0.5) {
            this.candidateListFilterDistance.add(element);
          }
        });
      }

      if (distanceSelectedOption == '500至2000公尺') {
        this.candidateListFilterTime.forEach((element) {
          if (double.parse(element['distance']) > 0.5 &&
              double.parse(element['distance']) < 2) {
            this.candidateListFilterDistance.add(element);
          }
        });
      }
    }

    if (this.candidateListFilterDistance.length != 0) {
      if (ratingSelectedOption == '不考慮') {
        this.candidateListFilterDistance.forEach((element) {
          this.candidateListFilterRating.add(element);
        });
      }

      if (ratingSelectedOption == '四顆星以上') {
        this
            .candidateListFilterDistance
            .sort((a, b) => (b['rating']).compareTo(a['rating']));
        this.candidateListFilterDistance.forEach((element) {
          this.candidateListFilterRating.add(element);
        });
      }
    }

    if (this.candidateListFilterRating.length != 0) {
      if (serviceSelectedOption == '不考慮') {
        this.candidateListFilterRating.forEach((element) {
          this.candidateListFilterService.add(element);
        });
      }
      if (serviceSelectedOption == '內用') {
        this.candidateListFilterRating.forEach((element) {
          if (element['inout'].contains(serviceSelectedOption)) {
            this.candidateListFilterService.add(element);
          }
        });
      }
      if (serviceSelectedOption == '外帶') {
        this.candidateListFilterRating.forEach((element) {
          if (element['inout'].contains(serviceSelectedOption)) {
            this.candidateListFilterService.add(element);
          }
        });
      }
    }

    if (this.candidateListFilterService.length != 0) {
      if (consumptionSelectedOption == '不考慮') {
        this.candidateListFilterService.forEach((element) {
          this.candidateListFilterConsumption.add(element);
        });
      }
      if (consumptionSelectedOption == '\$') {
        this.candidateListFilterService.forEach((element) {
          if (element['price_segment'] == 'p') {
            this.candidateListFilterConsumption.add(element);
          }
        });
      }
      if (consumptionSelectedOption == '\$\$') {
        this.candidateListFilterService.forEach((element) {
          if (element['price_segment'] == 'pp') {
            this.candidateListFilterConsumption.add(element);
          }
        });
      }
      if (consumptionSelectedOption == '\$\$\$') {
        this.candidateListFilterService.forEach((element) {
          if (element['price_segment'] == 'ppp') {
            this.candidateListFilterConsumption.add(element);
          }
        });
      }
      if (consumptionSelectedOption == '\$\$\$\$') {
        this.candidateListFilterService.forEach((element) {
          if (element['consumption'] == 'pppp') {
            this.candidateListFilterConsumption.add(element);
          }
        });
      }
    }

    if (this.candidateListFilterConsumption.length != 0) {
      if (this.candidateListFilterConsumption.length < 10) {
        for (int i = 0;
            i < this.candidateListFilterConsumption.length - 1;
            i++) {
          this.resultList.add(this.candidateListFilterConsumption[i]);
        }

        this.isLoading = false;
      } else {
        for (int i = 0; i < 10; i++) {
          this.resultList.add(this.candidateListFilterConsumption[i]);
        }
      }
    }

    print('dataList:  ${this.dataList.length}');
    print(
        'candidateListFilterPreference:  ${this.candidateListFilterPreference.length}');
    print('candidateListFilterTime:  ${this.candidateListFilterTime.length}');

    print(
        'candidateListFilterDistance:  ${this.candidateListFilterDistance.length}');
    print(
        'candidateListFilterRating:  ${this.candidateListFilterRating.length}');
    print(
        'candidateListFilterService:  ${this.candidateListFilterService.length}');

    print(
        'candidateListFilterConsumption:  ${this.candidateListFilterConsumption.length}');
    print(this.resultList);
    print('resultList:  ${this.resultList.length}');
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
    usersEvent.doc('zqX5VRLQnFaAWkRLGt5Q').update({
      'usersEventRecord': FieldValue.arrayUnion([
        {
          'user':
              Provider.of<Login>(context, listen: false).userData['userEmail'],
          'eventType': 'selectRestaurant',
          'timeStamp': DateFormat.yMd().add_Hms().format(DateTime.now()),
        }
      ])
    });
    usersEvent
        .doc(Provider.of<Login>(context, listen: false).userData['userEmail'])
        .update({
      'usersEventRecord': FieldValue.arrayUnion([
        {
          'eventType': 'selectRestaurant',
          'timeStamp': DateFormat.yMd().add_Hms().format(DateTime.now()),
        }
      ])
    });

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

    usersEvent.doc('zqX5VRLQnFaAWkRLGt5Q').update({
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
    usersEvent
        .doc(Provider.of<Login>(context, listen: false).userData['userEmail'])
        .update({
      'usersEventRecord': FieldValue.arrayUnion([
        {
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
              trailing: Text('${service.join('/')}'),
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
                  this.selectRestaurant(
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

  @override
  Widget build(BuildContext context) {
    return Consumer<Login>(
      builder: (context, login, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('recommendation'),
            ),
            body: this.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Scrollbar(
                    child: resultList.length == 0
                        ? Center(
                            child: Text('找到0筆相符的餐廳'),
                          )
                        : ListView.builder(
                            itemBuilder: (ctx, index) {
                              return resultItem(
                                  ctx,
                                  this.resultList[index]['name'],
                                  this.resultList[index]['address'],
                                  this.resultList[index]['cuisine_type'],
                                  this.resultList[index]['inout'],
                                  this.resultList[index]['price_segment'],
                                  login.selectedIntentionFactorSet[0]
                                          ['intentionFactors'][2]
                                      ['intentionFactorSelectedOption'],
                                  this.resultList[index]['distance'],
                                  this.resultList[index]['rating'],
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
                                  this.resultList[index]['cuisineList']);
                            },
                            itemCount: this.resultList.length,
                          ),
                  ));
      },
    );
  }
}
