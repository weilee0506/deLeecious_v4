import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonItem extends StatelessWidget {
  final date = DateFormat.yMMMMEEEEd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              'Filters',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.all(10),
          ),
          Container(
            child: Text(
              '請任意選擇過濾餐廳的因素',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.all(3),
          ),
          Container(
            child: Text(
              date,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            padding: EdgeInsets.all(3),
          ),
        ],
      ),
    );
  }
}
