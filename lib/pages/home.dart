import 'package:flutter/material.dart';

import 'package:first_project/products_manager.dart';

class HomePage extends StatelessWidget {
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
              title: Text('Manage Products'),
              onTap: () {},
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("EasyList"),
      ),
      body: ProductsManager(),
    );
  }
}