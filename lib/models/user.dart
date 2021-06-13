import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String eMail;
  final String group;

  User({
    @required this.id,
    @required this.name,
    @required this.eMail,
    @required this.group,
  });
}
