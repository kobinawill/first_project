import 'package:first_project/pages/product_edit_page.dart';
import 'package:first_project/scoped_model_class/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatefulWidget {
  final MainModel model;

  ProductListPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProductListPageState();
  }
}

class _ProductListPageState extends State<ProductListPage> {
  MainModel model;

  @override
  void initState() {
    widget.model.fetchData();
    super.initState();
  }

  _showSuccessDelete() {
    var alert = AlertDialog(
      title: Text('Deleted'),
      content: Text('Product successfully deleted'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Okay'),
        )
      ],
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: model.products.length,
                itemBuilder: (BuildContext context, int indexValue) {
                  return Dismissible(
                    onDismissed: (DismissDirection direction) {
                      if (direction == DismissDirection.endToStart) {
                        model.deleteProduct(indexValue).then((bool success) =>
                            success ? _showSuccessDelete() : Container());
                      }
                    },
                    background: Container(
                      //padding: EdgeInsets.all(5),
                      color: Theme.of(context).accentColor,
                      child: ListTile(
                        trailing: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    key: Key(model.products[indexValue].toString()),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  model.products[indexValue].image),
                            ),
                            title: Text(model.products[indexValue].title),
                            subtitle: Text('GH₵' +
                                model.products[indexValue].price.toString()),
                            trailing: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return ProductEditPage(
                                        productIndex: indexValue);
                                  }));
                                })),
                        Divider(
                          height: 8.0,
                        )
                      ],
                    ),
                  );
                });
      },
    );
  }
}
