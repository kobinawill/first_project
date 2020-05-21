/*
import 'package:flutter/material.dart';

class BuildList extends StatelessWidget {
  final Widget Function(BuildContext context, int indexValue) buildCard;
  List<Map<String, dynamic>> products;
  BuildList(this.buildCard, this.products);

  Widget buildProductList() {
    Widget buildProduct;
    if(products.length > 0){
      buildProduct = ListView.builder(
        itemBuilder: buildCard,
        itemCount: products.length,
      );
    } else {
      buildProduct = Center (child: Text("No product found, please enter product"),);
    }
    return buildProduct;
  }

  @override
  Widget build(BuildContext context) {
    return buildProductList();
  }
}*/
