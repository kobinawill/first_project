import 'package:first_project/pages/home.dart' as home;
import 'package:first_project/scoped_model_class/main_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final MainModel model = MainModel();

class ProductCreatePage extends StatefulWidget {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': null
  };

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  Widget _buildProductTextField() {
    return TextFormField(
      validator: (String value) {
        String val;
        if (value.isEmpty) {
          val = 'Title is required';
        }
        return val;
      },
      onSaved: (String value) {
        widget._formData['title'] = value;
      },
      decoration: InputDecoration(
          icon: Icon(
            Icons.title,
            size: 13,
          ),
          labelText: 'Product'),
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      //controller: null,
      validator: (String value) {
        String val;
        //|| !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)
        if (value.isEmpty) {
          val = 'Price is required and should be a number';
        }
        return val;
      },
      onSaved: (String value) {
        widget._formData['price'] = double.parse(value);
      },
      decoration: InputDecoration(
          icon: Icon(
            Icons.attach_money,
            size: 14,
          ),
          labelText: 'Price'),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildProductDescriptionTextField() {
    return TextFormField(
      //controller: null,
      validator: (String value) {
        String val;
        if (value.isEmpty) {
          val = 'Description is required';
        }
        return val;
      },
      onSaved: (String value) {
        widget._formData['description'] = value;
      },
      maxLines: 4,
      decoration: InputDecoration(
          hintText: 'Product Description',
          icon: Icon(
            Icons.message,
            size: 13,
          )),
    );
  }

  submitForm(BuildContext context, Function addProduct) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      addProduct(widget._formData['title'], widget._formData['description'],
              widget._formData['image'], widget._formData['price'])
          .then((bool success) {
        if (success) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return home.HomePage(model);
          }));
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Something went wrong'),
                  content: Text('Please try again'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text('Okay'),
                    )
                  ],
                );
              });
        }
      });
    } else {
      return;
    }
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: CircularProgressIndicator(),
                ),
              )
            : RaisedButton(
                color: Theme.of(context).accentColor,
                onPressed: () => submitForm(context, model.addProducts),
                child: Text(
                  "Add Product",
                  style: TextStyle(color: Colors.white),
                ),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double finalWidth = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: finalWidth / 2),
            children: <Widget>[
              _buildProductTextField(),
              _buildPriceTextField(),
              _buildProductDescriptionTextField(),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
