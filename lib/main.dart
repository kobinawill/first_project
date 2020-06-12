import 'package:first_project/controllers/pref_controller.dart';
import 'package:first_project/pages/home.dart';
import 'package:first_project/pages/manageproduct_page.dart';
import 'package:first_project/scoped_model_class/main_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:first_project/pages/login_page.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{
  MainModel model = MainModel();

  @override
  void initState(){
    model.autoAuthenticate();
    print('TOKEN RETURNED: ${model.userToken}');
    super.initState();
  }

@override
  Widget build(BuildContext context) {
  print('TOKEN RETURNED FROM BUILD: ${model.userToken}');
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              accentColor: Colors.deepPurple,
              brightness: Brightness.light
          ),
          home: model.userToken == null ? LoginPage() : HomePage(model),
          routes: {
            '/home_page': (BuildContext context){ return HomePage(model);},
            '/manage_product_page': (BuildContext context){return ManageProductsPage(model);},
            '/auth_page': (BuildContext context){ return LoginPage();}
          }
      ),
    );
  }
}
