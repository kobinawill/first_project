import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final String price;
  PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(5.0)
      ),
      padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 6.0),
      child: Text('GH₵$price', style: TextStyle(color: Colors.white),),
    );
  }
}