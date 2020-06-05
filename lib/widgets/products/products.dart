import 'package:first_project/models/product.dart';
import 'package:first_project/pages/product_page.dart';
import 'package:first_project/scoped_model_class/main_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'price_tag.dart';
import 'package:first_project/ui_elements/title_tag.dart';
import 'package:first_project/widgets/products/address_tag.dart';

class Products extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductsState();
  }

}

class _ProductsState extends State<Products> {

  Widget buildCard(BuildContext context, int indexValue) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Card(
          child: Column(
            children: <Widget>[
              Image.network(model.products[indexValue].image),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TitleTag(model.products[indexValue].title),
                  SizedBox(
                    width: 8.0,
                  ),
                  PriceTag(model.products[indexValue].price.toString())
                ],
              ),
              AddressTag('Union Square, San Francisco'),
              AddressTag('${model.products[indexValue].email}'),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.info,
                      color: Theme
                          .of(context)
                          .accentColor,
                    ),
                    onPressed: () {
                      Navigator.push<bool>(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return ProductPage(indexValue);
                          }));
                    },
                  ),
                  ScopedModelDescendant<MainModel>(
                    builder: (BuildContext context, Widget child, MainModel model){
                      return IconButton(
                        icon: Icon(model.products[indexValue].isFavourite == true ? Icons.favorite : Icons.favorite_border),
                        color: Colors.red,
                        onPressed: () {
                          model.toggleFavouriteStatus(indexValue);
                        },
                      );
                    },)
                ],
              )
            ],
          ),
        );
      },);
  }

  Widget buildProductList(List products, bool toggleFavourites) {
    Widget buildProduct;
    if (products.length > 0) {
      buildProduct = ListView.builder(
        itemBuilder: buildCard,
        itemCount: products.length,
      );
    } else if(toggleFavourites && products.length == 0){
      buildProduct = Center(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Text(
              "No products have been added to favourites",
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.italic),),
          )
      );
    }
    else {
      buildProduct = Center(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Text(
              "No product found, please go to manage products to add products",
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.italic),),
          )
      );
    }
    return buildProduct;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return buildProductList(model.displayFavouriteProducts, model.toggleFavourites);
      },);
  }
}
