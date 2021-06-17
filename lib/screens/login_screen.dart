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
    super.initState();
  }

  void _setLoginStatus(String emailInput) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _loginStatus = true;
      _userEmail = emailInput;
      prefs.setBool('loginStatus', _loginStatus);
      prefs.setString('userEmail', _userEmail);
    });
    print('${prefs.getString('userEmail')}  setLoginStatus-after');
    print('${prefs.getBool('loginStatus')}  setLoginStatus-after');
  }

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
            body: Column(
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
