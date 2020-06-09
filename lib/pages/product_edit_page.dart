import 'package:first_project/models/product.dart';
import 'package:first_project/pages/home.dart';
import 'package:first_project/scoped_model_class/main_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


final GlobalKey<FormState> _updateFormKey = GlobalKey<FormState>();
final MainModel model = MainModel();

class ProductEditPage extends StatefulWidget {
  final int productIndex;

  ProductEditPage({this.productIndex});

  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': null
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

  Widget updateButton(Function updateProduct) {
      return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
        return model.isLoading
            ? Center(
          child: Container(padding: EdgeInsets.only(top: 10), child: CircularProgressIndicator(),),)
            : Container(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              RaisedButton(
                color: Theme
                    .of(context)
                    .accentColor,
                onPressed: () => submitForm(context, updateProduct, model),
                child: Text(
                  "Edit Product",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
              ),
              RaisedButton(
                color: Theme
                    .of(context)
                    .accentColor,
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )

            ],
          ),
        );
      },);
  }


  submitForm(BuildContext context, Function updateProduct, MainModel model){
    if (_updateFormKey.currentState.validate()) {
      _updateFormKey.currentState.save();
    } else {
      return;
    }
    updateProduct(widget.productIndex,
        widget._formData['title'],
        widget._formData['description'],
        widget._formData['image'],
        widget._formData['price']
    ).then((_) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
            return HomePage(model);
          }));
    });
  }


  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double finalWidth = deviceWidth - targetWidth;

    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
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
                  updateButton(model.updateProduct),
                ],
              ),
            ),
          ),
        );
      },);
  }
}




