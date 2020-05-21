import 'package:flutter/material.dart';

import 'package:first_project/pages/manageproduct_page.dart';
import '../widgets/products/products.dart';
import 'package:first_project/models/product.dart';

List<Product> products = [];

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
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return ManageProductsPage();
                }));
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("EasyList"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          )
        ],
      ),
      body: Products(),
    );
  }
}