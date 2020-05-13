import 'package:first_project/pages/product_page.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function deleteProduct;
  Products(this.products, this.deleteProduct);

  Widget buildCard(BuildContext context, int indexValue){
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[indexValue]['image']),
          Text(products[indexValue]['title']),
          ButtonBar (
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () {
                  Navigator.push<bool>(context, MaterialPageRoute(builder: (BuildContext context){
                    return ProductPage(products[indexValue]['title'], products[indexValue]['image']);
                  })).then((bool value){
                    if (value){
                      deleteProduct(indexValue);
                    }
                  });
                },)
            ],
          )
        ],
      ),
    );
  }

  Widget buildProductList() {
    Widget buildProduct;
    if(products.length > 0){
      buildProduct = ListView.builder(
        itemBuilder: buildCard,
        itemCount: products.length,
      );
    } else {
      buildProduct = Center (child: Text("No product found, please enter product"),);
    }
    return buildProduct;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildProductList();
  }
}