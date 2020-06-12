import 'package:first_project/pages/login_page.dart';
import 'package:first_project/scoped_model_class/main_model.dart';
import 'package:flutter/material.dart';

class LogoutWidget extends StatelessWidget{
  final MainModel modelMain;
  LogoutWidget(this.modelMain);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('LogOut'),
      onTap: (){
        modelMain.logOut();
        Navigator.pushReplacementNamed(context, '/auth_page');
      },
    );
  }
}