import 'package:first_project/product_control.dart';
import 'package:flutter/material.dart';

import 'package:first_project/products.dart';

class ProductsManager extends StatefulWidget{
  final Map<String, String> startingProduct;
  ProductsManager({this.startingProduct});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductsManagerState();
  }
}

class _ProductsManagerState extends State<ProductsManager> {
  List<Map<String, String>> _products = [];

  @override
  void initState() {
    if (widget.startingProduct != null){
      _products.add(widget.startingProduct);
    }
    super.initState();
  }

  void _addProducts(Map<String, String> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index){
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(10.0),
          child: ProductControl(_addProducts),
        ),
        Expanded(
          child: Products( _products, _deleteProduct),
        )
      ],
    );
  }

}