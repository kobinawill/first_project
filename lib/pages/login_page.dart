import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  bool forSwitch = false;


  Widget _buildEmailTextField(){
    return TextField(
      controller: null,
      decoration: InputDecoration(
          labelText: 'Email',
          filled: true,
          fillColor: Colors.white
      ),
    );
  }
  Widget _buildPasswordTextField(){
    return TextField(
      controller: null,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Password'
      ),
      obscureText: true,
    );
  }
  Widget _buildSwitchListTileForAcceptTerms(){
    return SwitchListTile(
      title: Text('Accept Terms'),
      value: forSwitch,
      onChanged: (bool value){
        setState(() {
          forSwitch = value;
        });
      },
    );
  }
  Widget _buildLoginButton(){
    return RaisedButton(
      color: Theme.of(context).accentColor,
      onPressed: (){
        Navigator.pushReplacementNamed(context, '/home_page');
      },
      child: Text('LOGIN', style: TextStyle(color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;

    return Scaffold(
       appBar: AppBar(
         title: Text("Login"),
       ),
       body: Container(
           padding: EdgeInsets.all(10.0),
           decoration: BoxDecoration(
             image: DecorationImage(
                 fit: BoxFit.cover,
                 colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                 image: AssetImage('assets/background.jpg'))
           ),
           child: Center(
             child: Container(
               width: targetWidth,
               child: SingleChildScrollView(
                 child: Column(
                   children: <Widget>[
                     _buildEmailTextField(),
                     SizedBox(height: 10.0,),
                     _buildPasswordTextField(),
                     Padding(padding: EdgeInsets.all(5.0),),
                     _buildSwitchListTileForAcceptTerms(),
                     _buildLoginButton()
                 ],
               ),
             ),
           ),),
         ),
     );
  }
}