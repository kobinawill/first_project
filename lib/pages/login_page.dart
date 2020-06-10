import 'package:first_project/scoped_model_class/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

enum AuthMode { SignUp, Login }

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

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
      controller: _passwordController,
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

  Widget _buildConfirmPasswordTextFormField() {
    return TextFormField(
      validator: (String value) {
        String val;
        if (value.isEmpty) {
          val = 'Password is required';
        } else if (value != _passwordController.text) {
          val = 'Passwords do not match';
        }
        return val;
      },
      decoration: InputDecoration(
          filled: true, fillColor: Colors.white, labelText: 'Confirm Password'),
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

  Widget _buildLoginButton(Function login, Function signUp) {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      onPressed: () {
        _submit(login, signUp);
      },
      child: Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
          style: TextStyle(color: Colors.white)),
    );
  }

  void _submit(Function login, Function signUp) async {
    Map<String, dynamic> successInformation;
    if (_formKey.currentState.validate() && !_formData['acceptTerms']) {
      _formKey.currentState.save();
      if (_authMode == AuthMode.Login) {
        successInformation =
            await login(_formData['email'], _formData['password']);
        if (successInformation['success']) {
                 Navigator.pushReplacementNamed(context, '/home_page');
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error!'),
                  content: Text(successInformation['message']),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        }
      }
    } else if (_formKey.currentState.validate() && _formData['acceptTerms']) {
      _formKey.currentState.save();
      if (_authMode == AuthMode.SignUp) {
        successInformation =
            await signUp(_formData['email'], _formData['password']);
        if (successInformation['success']) {
                 Navigator.pushReplacementNamed(context, '/home_page');
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error!'),
                  content: Text(successInformation['message']),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        }
      }
    } else {
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
                        _authMode == AuthMode.SignUp
                            ? _buildConfirmPasswordTextFormField()
                            : Container(),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                        ),
                        _authMode == AuthMode.SignUp
                            ? _buildSwitchListTileForAcceptTerms()
                            : Container(),
                        FlatButton(
                          child: Text(
                              'Switch to ${_authMode == AuthMode.Login ? 'SignUp' : 'Login'}'),
                          onPressed: () {
                            setState(() {
                              if (_authMode == AuthMode.Login) {
                                _authMode = AuthMode.SignUp;
                              } else {
                                _authMode = AuthMode.Login;
                              }
                            });
                          },
                        ),
                        model.isLoading
                            ? CircularProgressIndicator()
                            : _buildLoginButton(model.login, model.signUp)
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
