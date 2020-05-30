import 'package:first_project/pages/home.dart';
import 'package:first_project/pages/manageproduct_page.dart';
import 'package:first_project/scoped_model_class/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:first_project/pages/login_page.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ProductModel>(
      model: ProductModel(),
      child: MaterialApp(
          theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              accentColor: Colors.deepPurple,
              brightness: Brightness.light
          ),
          home: LoginPage(),
          routes: {
            '/home_page': (BuildContext context){ return HomePage();},
            '/manage_product_page': (BuildContext context){return ManageProductsPage();}
          }
      ),
    );
  }
}
