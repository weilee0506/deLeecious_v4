import 'package:flutter/material.dart';

import '../widgets/common_item.dart';
import '../widgets/intentionFactor_input.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter-screen';
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CommonItem(),
        IntentionFactorInput(),
        // ButtonSet(),
      ],
    );
  }
}
