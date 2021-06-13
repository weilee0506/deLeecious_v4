import 'package:flutter/material.dart';

class Nullable<T> {
  T _value;
  Nullable(this._value);
  T get value {
    return _value;
  }
}

class IntentionFactor {
  final String factorName;
  final String factorId;
  final List<String> option;

  const IntentionFactor({
    @required this.factorName,
    @required this.factorId,
    @required this.option,
  });
}

class FactorSet {
  String context;
  List intentionFactor;
  Map<String, bool> factorStatus;
  Map<String, String> selectedOption;

  FactorSet({
    @required this.context,
    @required this.intentionFactor,
    @required this.factorStatus,
    @required this.selectedOption,
  });

  FactorSet copyWithImproved(
      {Nullable<String> context,
      Nullable<List> intentionFactor,
      Nullable<Map> factorStatus,
      Nullable<Map> selectedOption}) {
    return FactorSet(
        context: context == null
            ? this.context
            : context.value == null
                ? null
                : context.value,
        intentionFactor: intentionFactor == null
            ? this.intentionFactor
            : intentionFactor.value == null
                ? null
                : intentionFactor.value,
        factorStatus: factorStatus == null
            ? this.factorStatus
            : factorStatus.value == null
                ? null
                : factorStatus.value,
        selectedOption: selectedOption == null
            ? this.selectedOption
            : selectedOption.value == null
                ? null
                : selectedOption.value);
  }
}
