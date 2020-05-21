import 'package:first_project/models/product.dart';
import 'package:first_project/pages/product_edit_page.dart';
import 'package:first_project/scoped_model_class/product_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductModel>(
      builder: (BuildContext context, Widget child, ProductModel model){
        return ListView.builder(
            itemCount: model.products.length,
            itemBuilder: (BuildContext context, int indexValue) {
              return Dismissible(
                onDismissed: (DismissDirection direction){
                  if (direction == DismissDirection.endToStart){
                    model.deleteProduct(indexValue);
                  }
                },
                background: Container(
                  //padding: EdgeInsets.all(5),
                  color: Theme.of(context).accentColor,
                  child: ListTile(
                    trailing: Icon(Icons.delete,color: Colors.white,),
                  ),
                ),
                key: Key(model.products[indexValue].toString()),
                child: Column(
                  children: <Widget>[
                    ListTile(
                        leading: CircleAvatar(backgroundImage: AssetImage(model.products[indexValue].image),),
                        title: Text(model.products[indexValue].title),
                        subtitle: Text('\$'+model.products[indexValue].price.toString()),
                        trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext context) {
                                    return ProductEditPage(productIndex: indexValue); }));
                            })
                    ),
                    Divider(height: 8.0,)
                  ],
                ),
              );
            });
      },);
  }
}
