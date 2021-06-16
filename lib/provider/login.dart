import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';

class Login with ChangeNotifier {
  String _userEmail;

  var _userData;

  var _intnetionFactor;

  String _selectedIntentionFactorSetName;

  List _selectedIntentionFactorSet;

  String _currentContext;

  List _fitContextIntentionFactorSets;

  List<String> _fitContextIntentionFactorSetsName;

  Position _currenLocation;

  double _currentLatitude;

  double _currentLongitude;

  List _startTime = [0, 0, 0];

  List _endTime = [0, 0, 0];

  int _intentionFactorSetIndexForSystemInitiated;

  bool _check = false;

  WeatherFactory wf = new WeatherFactory('58dbf39967ed6036991d250caabcf477',
      language: Language.CHINESE_TRADITIONAL);
  String cityName = 'Taipei';
  String selectedContextValue = 'weekend';
  String weatherGoodBad;
  String weekdayWeekend;
  String dayNight;
  // String currentContext;
  // List fitContextIntentionFactorSets = [];
  // List<String> fitContextIntentionFactorSetsName = [];
  // String selectedIntentionFactorSetName;
  // Position _currentLocation;
  int weatherCount = 0;
  // int intentionFactorSetIndexForSystemInitiated;
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

  bool get isLogin {
    return _userEmail != null;
  }

  Map get userData {
    return _userData;
  }

  Map get intentionFactor {
    return _intnetionFactor;
  }

  String get selectedIntentionFactorSetName {
    return _selectedIntentionFactorSetName;
  }

  List get selectedIntentionFactorSet {
    return _selectedIntentionFactorSet;
  }

  String get currentContext {
    return _currentContext;
  }

  List get fitContextIntentionFactorSets {
    return _fitContextIntentionFactorSets;
  }

  List<String> get fitContextIntentionFactorSetsName {
    return _fitContextIntentionFactorSetsName;
  }

  Position get currentLocation {
    return _currenLocation;
  }

  double get currentLatitude {
    return _currentLatitude;
  }

  double get currentLongitude {
    return _currentLongitude;
  }

  List get startTime {
    return _startTime;
  }

  List get endTime {
    return _endTime;
  }

  int get intentionFactorSetIndexForSystemInitiated {
    return _intentionFactorSetIndexForSystemInitiated;
  }

  bool get check {
    return check;
  }

  void changecheck() {
    this._check = true;
  }

  void setIntentionFactorSetIndexForSystemInitiated(
      int intentionFactorSetIndexForSystemInitiated) {
    this._intentionFactorSetIndexForSystemInitiated =
        intentionFactorSetIndexForSystemInitiated;
  }

  void setStartTime(String startH, String startM, String startS) {
    // this._startTime.add(startH);
    // this._startTime.add(startM);
    // this._startTime.add(startS);
    this._startTime[0] = startH;
    this._startTime[1] = startM;
    this._startTime[2] = startS;
  }

  void setEndTime(String endH, String endM, String endS) {
    // this._startTime.add(endH);
    // this._startTime.add(endM);
    // this._startTime.add(endS);
    this._startTime[0] = endH;
    this._startTime[1] = endM;
    this._startTime[2] = endS;
  }

  void changeStatusAndSelected(int index, bool status) {
    this._selectedIntentionFactorSet[0]['intentionFactors'][index]
        ['intentionFactorStatus'] = status;
    this._selectedIntentionFactorSet[0]['intentionFactors'][index]
        ['intentionFactorSelectedOption'] = '不考慮';
  }

  void cancel(List intentionFactorSetForCancel) {
    // print('$_userDataForEdit  userDataForEdit before cancel');

    // _userDataForEdit = Map.from(_userDataForCancel);
    this._userData['userIntentionFactoeSet'] = intentionFactorSetForCancel;
    // print('$_userDataForEdit  userDataForEdit after cancel');
    notifyListeners();
  }

  void edit() {
    notifyListeners();
  }

  void save() {
    autoLogin();
  }

  void getCurrentContext(String currentContext) {
    this._currentContext = currentContext;
  }

  void resetFitContextSets() {
    this._fitContextIntentionFactorSets = [];
    this._fitContextIntentionFactorSetsName = [];
  }

  void getFitIntentionFactorSetsName(
    String fixIntentionFactorSetsName,
  ) {
    this._fitContextIntentionFactorSetsName.add(fixIntentionFactorSetsName);
  }

  void getFitIntentionFactorSets(Map fitIntentionFactorSets) {
    this._fitContextIntentionFactorSets.add(fitIntentionFactorSets);
    // print('getFit');
  }

  void getSelectedIntentionFactorSetName(
      String selectedIntentionFactorSetsName) {
    this._selectedIntentionFactorSetName = selectedIntentionFactorSetsName;
    notifyListeners();
  }

  Future resetSelectedIntentionFactorSetName(
      String afterSaveSelectedIntentionFactorSetName) async {
    this._selectedIntentionFactorSetName =
        afterSaveSelectedIntentionFactorSetName;

    this
        ._fitContextIntentionFactorSetsName
        .add(afterSaveSelectedIntentionFactorSetName);
  }

  // Future getSelectedIntentionFactorSetNoPersonalization() async {
  //   print('aa');
  //   this._selectedIntentionFactorSet = this._fitContextIntentionFactorSets;
  //   print('cc');
  //   print(this._selectedIntentionFactorSet);
  //   print(this._fitContextIntentionFactorSets);
  // }
  void getSelectedIntenitonFactorsetForSystemInitiated(
      Future getContext) async {
    await getContext;

    if (this._userData['userGroup'] == 'system-initiated') {
      this._selectedIntentionFactorSet = [];

      for (int i = 0; i < 8; i++) {
        if (this._userData['userIntentionFactorSets'][i]
                ['userIntentionFactorSetContext'] ==
            this._currentContext) {
          this
              ._selectedIntentionFactorSet
              .add(this._userData['userIntentionFactorSets'][i]);
          print('a  $i');
          notifyListeners();
        }
        print(i);
      }
    }
    // if (this._userData['userGroup'] == 'user-initiated') {
    //   this.resetFitContextSets();
    //   for (var i = 0;
    //       i < this._userData['userIntentionFactorSets'].length;
    //       i++) {
    //     this.getFitIntentionFactorSets(
    //         this._userData['userIntentionFactorSets'][i]);

    //     this.getFitIntentionFactorSetsName(
    //         this._userData['userIntentionFactorSets'][i]
    //             ['userIntentionFactorSetName']);
    //   }
    // }
    if (this._userData['userGroup'] == 'mix-initiated') {
      // this._selectedIntentionFactorSet = [];

      this.resetFitContextSets();
      for (var i = 0;
          i < this._userData['userIntentionFactorSets'].length;
          i++) {
        if (this._userData['userIntentionFactorSets'][i]
                ['userIntentionFactorSetContext'] ==
            this._currentContext) {
          this.getFitIntentionFactorSets(
              this._userData['userIntentionFactorSets'][i]);

          this.getFitIntentionFactorSetsName(
              this._userData['userIntentionFactorSets'][i]
                  ['userIntentionFactorSetName']);
          notifyListeners();
        }
      }
    }
    // if (this._userData['userGroup'] == 'no-personalization') {
    //   this.resetFitContextSets();
    //   this.getFitIntentionFactorSets(
    //       this._userData['userIntentionFactorSets'][0]);
    // }

    // this._selectedIntentionFactorSet = this._fitContextIntentionFactorSets;
    print(this._currentContext);
    print(this._selectedIntentionFactorSet);
    print(this._fitContextIntentionFactorSets);
    print(this._fitContextIntentionFactorSetsName);

    // print('system-initiated');
    print('user group:  ${this._userData['userGroup']}');

    // if (this._userData['userGroup'] == 'no-personalization') {
    //   await getContext;

    //   this._selectedIntentionFactorSet = this._fitContextIntentionFactorSets;
    //   print(this._selectedIntentionFactorSet);
    // }
    // if (this._userData['userGroup'] == 'user-initiated' ||
    //     this._userData['userGroup'] == 'mix-initiated') {
    //   await getContext;

    //   this._selectedIntentionFactorSet = this
    //       ._fitContextIntentionFactorSets
    //       .where((element) =>
    //           element['userIntentionFactorSetName'] ==
    //           this._selectedIntentionFactorSetName)
    //       .toList();
    // }
  }

  Future getSelectedIntentionFactorSet() async {
    if (this._userData['userGroup'] == 'no-personalization') {
      this._selectedIntentionFactorSet = this._fitContextIntentionFactorSets;
      print(this._selectedIntentionFactorSet);
    }

    // if (this._userData['userGroup'] == 'system-initiated') {
    //   this.get_context();
    //   for (int i = 0; i < 8; i++) {
    //     if (this._userData['userIntentionFactorSets'][i]
    //             ['userIntentionFactorSetName'] ==
    //         this._currentContext) {
    //       this._selectedIntentionFactorSet =
    //           this._userData['userIntentionFactorSets'][i];
    //     }
    //     print(i);
    //   }
    //   // this._selectedIntentionFactorSet = this._fitContextIntentionFactorSets;
    //   print(this._selectedIntentionFactorSet);
    //   print('system-initiated');
    // }

    // if (this._userData['userGroup'] == 'system-initiated') {
    //   this._selectedIntentionFactorSet = this._fitContextIntentionFactorSets;
    // }
    if (this._selectedIntentionFactorSetName != null) {
      this._selectedIntentionFactorSet = this
          ._fitContextIntentionFactorSets
          .where((element) =>
              element['userIntentionFactorSetName'] ==
              this._selectedIntentionFactorSetName)
          .toList();
      // notifyListeners();
    }
  }

  Future get_context() async {
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
    this._currentContext = '$weatherGoodBad$weekdayWeekend$dayNight';
    // for (int i = 0; i < 8; i++) {
    //   if (contextList[i] == currentContext) {
    //     intentionFactorSetIndexForSystemInitiated = i;
    //     print('check');
    //   }
    // }

    // Provider.of<Login>(context, listen: false)
    //     .getCurrentContext(currentContext);
    print('aa $weather');
  }

  // Future getSelectedIntentionFactorSetUserInitiated()async{
  //   this._selectedIntentionFactorSet =
  // }

  Future getCurrentLocation(Position currentLocation) async {
    this._currenLocation = currentLocation;
  }

  Future getCurrentLatitude(double currentLat) async {
    this._currentLatitude = currentLat;
  }

  Future getCurrentLongitude(double currentLon) async {
    this._currentLongitude = currentLon;
  }

  Future login(String userEmailInput) async {
    Map<String, dynamic> resultData;
    Map<String, dynamic> intentionFactorData;

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .where("userEmail", isEqualTo: userEmailInput)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        print('wrong haha');
      } else {
        querySnapshot.docs.forEach((result) async {
          resultData = Map<String, dynamic>.from(result.data());

          _userData = resultData;
          // _userDataForCancel = Map<String, dynamic>.from(result.data());
          // _userDataForEdit = Map<String, dynamic>.from(result.data());

          _userEmail = resultData['userEmail'];
          notifyListeners();
          print('resultData: $resultData');

          final prefs = await SharedPreferences.getInstance();
          prefs.setString('userEmail', _userEmail);
          print('userEmail: $_userEmail');
        });
      }
    });

    CollectionReference intentionFactors =
        FirebaseFirestore.instance.collection('intentionFactors');
    intentionFactors.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) async {
        intentionFactorData = Map<String, dynamic>.from(result.data());
        _intnetionFactor = intentionFactorData;
      });
    });
  }

  Future<bool> autoLogin() async {
    Map<String, dynamic> resultData;
    Map<String, dynamic> intentionFactorData;

    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userEmail')) {
      print('auto login fails');
      return false;
    }

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .where("userEmail", isEqualTo: prefs.getString('userEmail'))
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) async {
        resultData = Map<String, dynamic>.from(result.data());
        _userData = resultData;
        // _userDataForCancel = Map<String, dynamic>.from(result.data());
        // _userDataForEdit = Map<String, dynamic>.from(result.data());
        _userEmail = resultData['userEmail'];
      });
    });

    CollectionReference intentionFactors =
        FirebaseFirestore.instance.collection('intentionFactors');
    intentionFactors.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) async {
        intentionFactorData = Map<String, dynamic>.from(result.data());
        _intnetionFactor = intentionFactorData;
      });
    });
    print('auto login success');
    notifyListeners();
    return true;
  }
}
