import 'package:first_project/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductModel extends Model {
  List<Product> products;

  List<Product> get product {
      return List.from(products);
  }

  void addProducts(Product product) {
    products.add(product);
  }

  void updateProduct(int index, Product productNew) {
    products[index] = productNew;
  }

  void deleteProduct(int index) {
    products.removeAt(index);
  }
}
