import 'package:flutter/material.dart';

class Product {
  String id;
  String title;
  String description;
  String image;
  double price;
  bool isFavourite;
  String email;
  String userId;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.image,
    @required this.price,
    @required this.email,
    @required this.userId,
    this.isFavourite = false
});


}