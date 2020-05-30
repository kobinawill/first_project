import 'package:first_project/scoped_model_class/product_model.dart';
import 'package:flutter/material.dart';

import 'package:first_project/pages/manageproduct_page.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/products/products.dart';


class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Choose'),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Manage Products'),
              onTap: () {
                Navigator.popAndPushNamed(context, '/manage_product_page');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("EasyList"),
        actions: <Widget>[
          ScopedModelDescendant<ProductModel>(builder: (BuildContext context, Widget child, ProductModel model){
            return IconButton(
              icon: Icon(model.toggleFavourites ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                model.toggleFavouritesSwitch();
              },
            );
          },)
        ],
      ),
      body: Products(),
    );
  }
}