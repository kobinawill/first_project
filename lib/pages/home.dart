import 'package:first_project/scoped_model_class/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/products/products.dart';

class HomePage extends StatefulWidget {
  final MainModel model;

  HomePage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.model.fetchData();
    //widget.model.loadToken();
    super.initState();
  }

  Widget _buildProductList() {
    Widget checkLoading = Center(
      child: CircularProgressIndicator(),
    );
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (!model.isLoading) {
          //print('${model.isLoading}');
          checkLoading = Products();
        }else if(model.isLoading){
          //print('${model.isLoading}');
          checkLoading = checkLoading;
        } return RefreshIndicator(
          onRefresh: () {
            return model.fetchData();
          },
          child: checkLoading,
        );
      },
    );
  }

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
        title: Text("Asime"),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: Icon(model.toggleFavourites
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  model.toggleFavouritesSwitch();
                },
              );
            },
          )
        ],
      ),
      body: _buildProductList(),
    );
  }
}
