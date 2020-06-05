import 'package:flutter/material.dart';

class User {
  final String userId;
  final String password;
  final String email;

  User({
    @required this.email,
    @required this.password,
    @required this.userId
});

}