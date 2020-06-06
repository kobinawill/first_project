import 'package:first_project/scoped_model_class/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };

  Widget _buildEmailTextFormField() {
    return TextFormField(
      validator: (String value) {
        String val;
        if (value.isEmpty ||
            !RegExp(r'^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$')
                .hasMatch(value)) {
          val = 'Email is required and should be valid';
        }
        return val;
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: 'Email', filled: true, fillColor: Colors.white),
    );
  }

  Widget _buildPasswordTextFormField() {
    return TextFormField(
      validator: (String value) {
        String val;
        if (value.isEmpty) {
          val = 'Password is required';
        }
        return val;
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
      decoration: InputDecoration(
          filled: true, fillColor: Colors.white, labelText: 'Password'),
      obscureText: true,
    );
  }

  Widget _buildSwitchListTileForAcceptTerms() {
    return SwitchListTile(
      title: Text('Accept Terms'),
      value: _formData['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
    );
  }

  Widget _buildLoginButton(Function login) {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      onPressed: () {
        _submit(login);
      },
      child: Text('LOGIN', style: TextStyle(color: Colors.white)),
    );
  }

  void _submit(Function login) {
    if (_formKey.currentState.validate() && _formData['acceptTerms']) {
      _formKey.currentState.save();
      login(_formData['email'], _formData['password']);
      Navigator.pushReplacementNamed(context, '/home_page');

    }else{
      return;
    }
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
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop),
                image: AssetImage('assets/background.jpg'))),
        child: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            return Center(
              child: Container(
                width: targetWidth,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _buildEmailTextFormField(),
                        SizedBox(
                          height: 10.0,
                        ),
                        _buildPasswordTextFormField(),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                        ),
                        _buildSwitchListTileForAcceptTerms(),
                        _buildLoginButton(model.login)
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
