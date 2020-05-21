import 'package:first_project/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductModel extends Model {
  List<Product> _products = [];

  List<Product> get products {
      return List.from(_products);
  }

  void addProducts(Product newProduct) {
    _products.add(newProduct);
  }

  void updateProduct(int index, Product newProduct) {
    _products[index] = newProduct;
  }

  void deleteProduct(int index) {
    _products.removeAt(index);
  }
}
