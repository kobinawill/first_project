import 'package:first_project/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductModel extends Model {
  List<Product> _products = [];
  bool _switchFavourites = false;

  List<Product> get products {
      return List.from(_products);
  }

  void toggleFavouritesSwitch(){
    _switchFavourites = !_switchFavourites;
    notifyListeners();
  }

  bool get toggleFavourites {
    return _switchFavourites;
  }

  List<Product> get displayFavouriteProducts {
    if(_switchFavourites){
      return List.from(_products.where((Product product) => product.isFavourite));
    }else{
      return List.from(_products);
    }
  }

  void addProducts(Product newProduct) {
    _products.add(newProduct);
    notifyListeners();
  }

  void updateProduct(int index, Product newProduct) {
    _products[index] = newProduct;
    notifyListeners();
  }

  void toggleFavouriteStatus(int index){
     bool newFavourite = !_products[index].isFavourite;
     Product updatedProduct = new Product(
        title: _products[index].title,
        description: _products[index].description,
        image: _products[index].image,
        price: _products[index].price,
        isFavourite: newFavourite
      );
      _products[index] = updatedProduct;
      notifyListeners();
  }

  void deleteProduct(int index) {
    _products.removeAt(index);
    notifyListeners();
  }
}
