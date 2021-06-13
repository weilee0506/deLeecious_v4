// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/login.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loginStatus;
  String _userEmail;

  final emailInputController = TextEditingController();

  @override
  void initState() {
    // _loadLoginStatus();

    super.initState();

    // _getData(_userEmail);
  }

  // @override
  // void didChangeDependencies() {
  //   _getData(_userEmail);
  //   super.didChangeDependencies();
  // }

  // void _loadLoginStatus() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   setState(() {
  //     print(
  //         '${Provider.of<UsedData>(context, listen: false).loginStatus} before_loadLoginStatus-provider');

  //     Provider.of<UsedData>(context, listen: false).loginStatus =
  //         prefs.getBool('loginStatus');
  //     Provider.of<UsedData>(context, listen: false).userEmail =
  //         (prefs.getString('userEmail'));
  //     if (Provider.of<UsedData>(context, listen: false).loginStatus == null) {
  //       Provider.of<UsedData>(context, listen: false).loginStatus = false;
  //       prefs.setBool('loginStatus',
  //           Provider.of<UsedData>(context, listen: false).loginStatus);
  //     }
  //     if (Provider.of<UsedData>(context, listen: false).userEmail == null) {
  //       Provider.of<UsedData>(context, listen: false).userEmail = '';
  //       prefs.setString('userEmail',
  //           Provider.of<UsedData>(context, listen: false).userEmail);
  //     }
  //     print(
  //         '${Provider.of<UsedData>(context, listen: false).userEmail}  loadLoginStatus-provider');
  //     print(
  //         '${Provider.of<UsedData>(context, listen: false).loginStatus}  loadLoginStatus-provider');
  //     print('${prefs.getString('userEmail')}  loadLoginStatus-prefs');
  //     print('${prefs.getBool('loginStatus')}  loadLoginStatus-prefs');
  //   });
  // }

  void _setLoginStatus(String emailInput) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Provider.of<UsedData>(context, listen: false).loginStatus = true;
      // Provider.of<UsedData>(context, listen: false).userEmail = emailInput;
      _loginStatus = true;
      _userEmail = emailInput;
      prefs.setBool('loginStatus', _loginStatus);
      prefs.setString('userEmail', _userEmail);
      // _getData(emailInput);
    });
    print('${prefs.getString('userEmail')}  setLoginStatus-after');
    print('${prefs.getBool('loginStatus')}  setLoginStatus-after');
  }

  // void _resetLoginStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.clear();

  //   setState(() {
  //     Provider.of<UsedData>(context, listen: false).loginStatus = false;
  //     Provider.of<UsedData>(context, listen: false).userEmail = '';
  //     prefs.setBool('loginStatus',
  //         Provider.of<UsedData>(context, listen: false).loginStatus);
  //     prefs.setString(
  //         'userEmail', Provider.of<UsedData>(context, listen: false).userEmail);
  //     // (Provider.of<UsedData>(context, listen: false).user['userGroup']) = {};
  //   });
  // }

  // void _getData(String userEmail) {
  //   FirebaseFirestore.instance
  //       .collection('intentionFactors')
  //       .get()
  //       .then((QuerySnapshot docs) {
  //     Provider.of<UsedData>(context, listen: false).intentionFactor =
  //         docs.docs[0].data();
  //   });

  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .where('userEmail', isEqualTo: userEmail)
  //       .get()
  //       .then((QuerySnapshot docs) {
  //     if (docs.docs.isNotEmpty) {
  //       // _setLoginStatus();
  //       // print(_loginStatus);
  //       // print('$userEmail   getData userEmail');
  //       Provider.of<UsedData>(context, listen: false).user =
  //           docs.docs[0].data();
  //       // print('${docs.docs[0].data()}  getData firebase ');
  //       // print('${Provider.of<UsedData>(context, listen: false).user}  getData');
  //     }
  //   });

  //   setState(() {
  //     Provider.of<UsedData>(context, listen: false).userEmail = userEmail;
  //   });
  // }

  Future<void> _submit(String emailInput) async {
    final prefs = await SharedPreferences.getInstance();
    await Provider.of<Login>(context, listen: false).login(emailInput);
    if (prefs.getString('userEamil') == null) {
      emailInputController.clear();
    }
  }

  @override
  void dispose() {
    emailInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Login>(
      builder: (context, login, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('login'),
            ),
            body:
                // Provider.of<UsedData>(context, listen: false).loginStatus
                //     ? Row(
                //         children: [
                //           TextButton(
                //               onPressed: () {
                //                 print('login');
                //                 _getData(
                //                     Provider.of<UsedData>(context, listen: false)
                //                         .userEmail);
                //                 Navigator.pushNamed(context, TabsScreen.routeName);
                //                 // print(
                //                 //     '${Provider.of<UsedData>(context, listen: false).emailInput}   email from provider');
                //                 // print(
                //                 //     '${(Provider.of<UsedData>(context, listen: false).user['userGroup'])}   login');
                //               },
                //               child: Text('start')),
                //           TextButton(
                //               onPressed: _resetLoginStatus, child: Text('logout')),
                //         ],
                //       )
                // :
                Column(
              children: <Widget>[
                Text(
                  '歡迎',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '請輸入你的email',
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                            ),
                          ),
                          controller: emailInputController,
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          // print('${emailInputController.text}  press input');

                          // FirebaseFirestore.instance
                          //     .collection('users')
                          //     .where('userEmail',
                          //         isEqualTo: emailInputController.text)
                          //     .get()
                          //     .then((QuerySnapshot docs) {
                          //   if (docs.docs.isNotEmpty) {
                          //     // _setLoginStatus(emailInputController.text);
                          //     // Navigator.pushNamed(
                          //     //     context, TabsScreen.routeName);
                          //     _submit(emailInputController.text);
                          //   } else {
                          //     setState(() {
                          //       emailInputController.clear();
                          //     });
                          //     print('wrong');
                          //   }
                          // });
                          _submit(emailInputController.text);
                        },
                        child: Text('enter')),
                  ],
                ),
              ],
            ));
      },
    );
  }
}
