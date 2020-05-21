import 'package:first_project/models/product.dart';
import 'package:first_project/pages/home.dart';
import 'package:first_project/scoped_model_class/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


final GlobalKey<FormState> _updateFormKey = GlobalKey<FormState>();


class ProductEditPage extends StatefulWidget {
  final int productIndex;

  ProductEditPage({this.productIndex});

  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {

  Widget _buildProductTextField(Product product) {
    return TextFormField(
      initialValue: product.title,
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
      decoration:
      InputDecoration(icon: Icon(Icons.title, size: 13,), labelText: 'Product'),
    );
  }

  Widget _buildPriceTextField(Product product) {
    return TextFormField(
      //controller: null,
      initialValue: product.price.toString(),
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
          icon: Icon(Icons.attach_money, size: 14,), labelText: 'Price'),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildProductDescriptionTextField(Product product) {
    return TextFormField(
      //controller: null,
      initialValue: product.description,
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
          icon: Icon(Icons.message, size: 13,)),
    );
  }

  Widget updateButton(BuildContext context, Function updateProduct) {
    return RaisedButton(
      color: Theme
          .of(context)
          .accentColor,
      onPressed: () {
        if (_updateFormKey.currentState.validate()) {
          _updateFormKey.currentState.save();
        } else {
          return;
        }
        updateProduct(widget.productIndex, Product(
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
    final double deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double finalWidth = deviceWidth - targetWidth;

    return ScopedModelDescendant<ProductModel>(
      builder: (BuildContext context, Widget child, ProductModel model){
        Product product = model.products[widget.productIndex];
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
                  _buildProductTextField(product),
                  _buildPriceTextField(product),
                  _buildProductDescriptionTextField(product),
                  updateButton(context, model.updateProduct)
                ],
              ),
            ),
          ),
        );
      },);
  }
}




