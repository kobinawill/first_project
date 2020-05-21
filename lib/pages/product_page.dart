import 'package:first_project/scoped_model_class/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:first_project/ui_elements/title_tag.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductPage extends StatelessWidget {
  final int productIndex;
  ProductPage(this.productIndex);

  /* _showWarning(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Are you sure?'),
        content: Text('This action cannot be undone!'),
        actions: <Widget>[
          FlatButton(
            child: Text('DISCARD'),
            onPressed: (){
              Navigator.pop(context);
            },),
          FlatButton(
            child: Text('CONTINUE'),
            onPressed: (){
              Navigator.pop(context);
              Navigator.pop(context, true);
            },)
        ],
      );
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: ScopedModelDescendant<ProductModel>(
        builder: (BuildContext context, Widget child, ProductModel model){
          return Scaffold(
            appBar: AppBar(
              title: Text(model.products[productIndex].title),
            ),
            body: Center(
              child: Column(
                children: <Widget>[
                  Image.asset(model.products[productIndex].image),
                  Padding(padding: const EdgeInsets.all(10.0),),
                  TitleTag(model.products[productIndex].title),
                  Padding(padding: const EdgeInsets.all(7.0),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Union Square, San Francisco', style: TextStyle(fontFamily: 'Oswald'),),
                      Row(
                        children: <Widget>[
                          Text('  |  ', style: TextStyle(fontFamily: 'Oswald'),),
                          Text('\$${model.products[productIndex].price}', style: TextStyle(fontFamily: 'Oswald'),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Text(model.products[productIndex].description)
                  /*RaisedButton(
                onPressed: () {
                  _showWarning(context);
                },
                child: Text("DELETE"),
                color: Theme.of(context).accentColor,
              )*/
                ],
              ),
            ),
          );
        },),
    );
  }
}
