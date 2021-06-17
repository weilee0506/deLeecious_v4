import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'intentionFactor_set.dart';

import 'adaptiveContext_dropdown.dart';
import 'button_set.dart';

import '../provider/login.dart';

class IntentionFactorInput extends StatefulWidget {
  @override
  _IntentionFactorInputState createState() => _IntentionFactorInputState();
}

String contextValue = 'weekend';

class _IntentionFactorInputState extends State<IntentionFactorInput> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Login>(
      builder: (context, login, child) {
        // print(usedData.factorSetValue.factorStatus);
        return Expanded(
          // child: Container(
          // height: 500,
          child: Column(
            children: <Widget>[
              AdaptiveContextDropdown(),
              IntentionFactorSet(),
              ButtonSet()
            ],
          ),
          // ),
        );
      },
    );
  }
}
