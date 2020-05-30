import 'package:flutter/material.dart';

class Product {
  String title;
  String description;
  String image;
  double price;
  bool isFavourite;

  Product({
    @required this.title,
    @required this.description,
    @required this.image,
    @required this.price,
    this.isFavourite = false
});


}