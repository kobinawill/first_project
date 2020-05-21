import 'package:first_project/models/product.dart';
import 'package:first_project/pages/product_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'price_tag.dart';
import 'package:first_project/ui_elements/title_tag.dart';
import 'package:first_project/widgets/products/address_tag.dart';

class Products extends StatelessWidget {
  final List<Product> products;

  Products(this.products);

  Widget buildCard(BuildContext context, int indexValue) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[indexValue].image),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TitleTag(products[indexValue].title),
              SizedBox(
                width: 8.0,
              ),
              PriceTag(products[indexValue].price.toString())
            ],
          ),
          AddressTag('Union Square, San Francisco'),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.info,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  Navigator.push<bool>(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return ProductPage(
                        products[indexValue].title,
                        products[indexValue].image,
                        products[indexValue].description,
                        products[indexValue].price.toString());
                  }));
                },
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                color: Colors.red,
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildProductList() {
    Widget buildProduct;
    if (products.length > 0) {
      buildProduct = ListView.builder(
        itemBuilder: buildCard,
        itemCount: products.length,
      );
    } else{
      buildProduct = Center(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Text("No product found, please go to manage products to add products", textAlign: TextAlign.center,
          style: TextStyle(fontStyle: FontStyle.italic),),
        )
      );
    }
    return buildProduct;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildProductList();
  }
}
