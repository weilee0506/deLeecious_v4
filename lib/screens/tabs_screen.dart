import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import './filter_screen.dart';
import './profile_screen.dart';
import '../provider/login.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tab-screen';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': FilterScreen(),
        'title': 'filter',
      },
      {
        'page': ProfileScreen(),
        //widget在原本宣告_pages的地方不能使用，因此移到initState
        'title': 'profile',
      },
    ];

    Provider.of<Login>(context, listen: false).setStartTime(
        DateFormat.H().format(DateTime.now()),
        DateFormat.m().format(DateTime.now()),
        DateFormat.s().format(DateTime.now()));
    super.initState();
  }

  void _selectPage(int index) {
    if (mounted) {
      setState(() {
        _selectedPageIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('deLeecious'),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedFontSize: 14,
        selectedFontSize: 14,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_alt_outlined),
            label: 'filters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
