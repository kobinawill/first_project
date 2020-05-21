import 'package:first_project/models/product.dart';
import 'package:first_project/pages/home.dart' as home;
import 'package:first_project/scoped_model_class/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';



final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



class ProductCreatePage extends StatefulWidget {
  final Map<String, dynamic> _formData = {
    'title' : null,
    'description' : null,
    'price' : null,
    'image': 'assets/food.jpg'
  };

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage>{

  Widget _buildProductTextField(){
    return TextFormField(
      validator: (String value){
        String val;
        if (value.isEmpty){
          val = 'Title is required';
        }
        return val;
      },
      onSaved: (String value){
        widget._formData['title'] = value;
      },
      decoration:
      InputDecoration(icon: Icon(Icons.title, size: 13,), labelText: 'Product'),
    );
  }
  Widget _buildPriceTextField(){
    return TextFormField(
      //controller: null,
      validator: (String value){
        String val;
        //|| !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)
        if(value.isEmpty){
          val = 'Price is required and should be a number';
        }
        return val;
      },
      onSaved: (String value) {
          widget._formData['price'] = double.parse(value);
      },
      decoration: InputDecoration(
          icon: Icon(Icons.attach_money, size: 14,), labelText: 'Price'),
      keyboardType: TextInputType.number,
    );
  }
  Widget _buildProductDescriptionTextField(){
    return TextFormField(
      //controller: null,
      validator: (String value){
        String val;
        if(value.isEmpty){
          val = 'Description is required';
        }
        return val;
      },
      onSaved: (String value) {
        widget._formData['description'] = value;
      },
      maxLines: 4,
      decoration: InputDecoration(
          hintText: 'Product Description', icon: Icon(Icons.message, size: 13,)),
    );
  }
  Widget saveButton(BuildContext context ,Function function) {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      onPressed: () {
        if (_formKey.currentState.validate()){
          _formKey.currentState.save();
          function(Product(
              image: widget._formData['image'],
              title: widget._formData['title'],
              description: widget._formData['description'],
              price: widget._formData['price'])
          );
        }else{
          return;
        }
        print("${home.products}");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return home.HomePage();
            }));
      },
      child: Text(
        "Add Product",
        style: TextStyle(color: Colors.white),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double finalWidth = deviceWidth - targetWidth;

    return ScopedModelDescendant<ProductModel>(builder: (BuildContext context, Widget child, ProductModel model){
      return GestureDetector(
        onTap: (){
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
                saveButton(context, model.addProducts)
              ],
            ),
          ),
        ),
      );
    },);
  }
}



