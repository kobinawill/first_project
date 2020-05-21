import 'package:first_project/models/product.dart';
import 'package:first_project/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


final GlobalKey<FormState> _updateFormKey = GlobalKey<FormState>();



class ProductEditPage extends StatefulWidget {
  final Product product;
  final int productIndex;
  final Function updateProduct;
  ProductEditPage({this.productIndex, this.product, this.updateProduct});

  final Map<String, dynamic> _formData = {
    'title' : null,
    'description' : null,
    'price' : null,
    'image': 'assets/food.jpg'
  };

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage>{

  Widget _buildProductTextField(){
    return TextFormField(
      initialValue: widget.product.title,
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
      initialValue: widget.product.price.toString(),
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
      initialValue: widget.product.description,
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
  Widget updateButton(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      onPressed: () {
        if (_updateFormKey.currentState.validate()){
          _updateFormKey.currentState.save();
        }else{
          return;
        }
        widget.updateProduct(widget.productIndex, Product(
          title: widget._formData['title'],
          description: widget._formData['description'],
          image: widget._formData['image'],
          price: widget._formData['price']
        ));
        print("${widget.productIndex}");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return HomePage();
            }));
      },
      child: Text(
        "Edit Product",
        style: TextStyle(color: Colors.white),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double finalWidth = deviceWidth - targetWidth;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Form(
          key: _updateFormKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: finalWidth / 2),
            children: <Widget>[
              _buildProductTextField(),
              _buildPriceTextField(),
              _buildProductDescriptionTextField(),
              updateButton(context)
            ],
          ),
        ),
      ),
    );
  }
}




