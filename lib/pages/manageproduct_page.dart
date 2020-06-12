import 'package:first_project/pages/product_create_page.dart';
import 'package:first_project/pages/product_list_page.dart';
import 'package:first_project/scoped_model_class/main_model.dart';
import 'package:first_project/ui_elements/logout_listtile_widget.dart';
import 'package:flutter/material.dart';

import 'package:first_project/pages/home.dart';

class ManageProductsPage extends StatelessWidget {
  final MainModel model;

  ManageProductsPage(this.model);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(title: Text('Choose'),),
              ListTile(
                leading: Icon(Icons.shop),
                title: Text('All Products'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/home_page' );
                },
              ),
              Divider(),
              LogoutWidget(model),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Manage Products"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'Create Product',),
              Tab(
                icon: Icon(Icons.list),
                text: 'My Products',)
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[
          ProductCreatePage(),
          ProductListPage(model)
        ],)
      ),
    );
  }
}
