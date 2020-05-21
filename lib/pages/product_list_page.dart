import 'package:first_project/models/product.dart';
import 'package:first_project/pages/product_edit_page.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  List<Product> products;
  final Function updateProduct;
  final Function deleteProduct;

  ProductListPage(this.products, this.updateProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int indexValue) {
            return Dismissible(
              onDismissed: (DismissDirection direction){
                if (direction == DismissDirection.endToStart){
                  deleteProduct(indexValue);
                }
              },
              background: Container(
                //padding: EdgeInsets.all(5),
                color: Theme.of(context).accentColor,
                child: ListTile(
                  trailing: Icon(Icons.delete,color: Colors.white,),
                ),
              ),
              key: Key(products[indexValue].toString()),
              child: Column(
                  children: <Widget>[
                    ListTile(
                        leading: CircleAvatar(backgroundImage: AssetImage(products[indexValue].image),),
                        title: Text(products[indexValue].title),
                        subtitle: Text('\$'+products[indexValue].price.toString()),
                        trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext context) {
                                    return ProductEditPage(
                                        productIndex: indexValue,
                                        product: products[indexValue],
                                        updateProduct: updateProduct);
                                  }));
                            })
                    ),
                    Divider(height: 8.0,)
                  ],
                ),
            );
          });
  }
}
