import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:first_project/ui_elements/title_tag.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final String price;
  ProductPage(this.title, this.imageUrl, this.description, this.price);

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
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Image.asset(imageUrl),
              Padding(padding: const EdgeInsets.all(10.0),),
              TitleTag(title),
              Padding(padding: const EdgeInsets.all(7.0),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Union Square, San Francisco', style: TextStyle(fontFamily: 'Oswald'),),
                  Row(
                    children: <Widget>[
                      Text('  |  ', style: TextStyle(fontFamily: 'Oswald'),),
                      Text('\$$price', style: TextStyle(fontFamily: 'Oswald'),)
                    ],
                  )
                ],
              ),
              SizedBox(height: 20.0,),
              Text(description)
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
      ),
    );
  }
}
