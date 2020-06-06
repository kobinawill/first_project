import 'dart:convert';

import 'package:first_project/models/product.dart';
import 'package:first_project/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with ConnectedModels, ProductModel, UserModel {}

mixin ConnectedModels on Model {
  List<Product> _products = [];
  User _authenticatedUser;
  bool isLoading = true;

  List<Product> get products {
    return List.from(_products);
  }

  void login(String email, String password) {
    _authenticatedUser =
        new User(email: email, password: password, userId: 'tkhdklh');
  }

  Future<bool> addProducts(
      String title, String description, String image, double price) {
    isLoading = true;
    notifyListeners();
    Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://cdn.pixabay.com/photo/2015/10/02/12/00/chocolate-968457_960_720.jpg',
      'price': price,
      'email': _authenticatedUser.email,
      'userId': _authenticatedUser.userId
    };

    return http
        .post('https://flutter-products-b7b5f.firebaseio.com/products.json',
            body: json.encode(productData))
        .then((http.Response response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        isLoading = false;
        notifyListeners();
        return false;
      }
      Map<String, dynamic> responseData = json.decode(response.body);
      _products.add(new Product(
        id: responseData['name'],
        title: title,
        description: description,
        image:
            'https://cdn.pixabay.com/photo/2015/10/02/12/00/chocolate-968457_960_720.jpg',
        price: price,
        email: _authenticatedUser.email,
        userId: _authenticatedUser.userId,
      ));
      isLoading = false;
      return true;
    });
  }

  Future<Null> updateProduct(
      int index, String title, String description, String image, double price) {
    isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updatedData = {
      'title': title,
      'description': description,
      'image':
          'https://cdn.pixabay.com/photo/2015/10/02/12/00/chocolate-968457_960_720.jpg',
      'price': price,
      'email': _authenticatedUser.email,
      'userId': _authenticatedUser.userId,
    };
    return http
        .put(
            'https://flutter-products-b7b5f.firebaseio.com/products/${_products[index].id}.json',
            body: json.encode(updatedData))
        .then((http.Response response) {
      Product newProduct = Product(
        id: _products[index].id,
        title: title,
        description: description,
        image:
            'https://cdn.pixabay.com/photo/2015/10/02/12/00/chocolate-968457_960_720.jpg',
        price: price,
        email: _products[index].email,
        userId: _products[index].userId,
      );
      _products[index] = newProduct;
      isLoading = false;
      notifyListeners();
    });
  }

  void toggleFavouriteStatus(int index) {
    bool newFavourite = !_products[index].isFavourite;
    Product updatedProduct = new Product(
        id: _products[index].id,
        title: _products[index].title,
        description: _products[index].description,
        image: _products[index].image,
        price: _products[index].price,
        email: _products[index].email,
        userId: _products[index].userId,
        isFavourite: newFavourite);
    _products[index] = updatedProduct;
    notifyListeners();
  }

  bool get nowLoading => isLoading;
}

mixin ProductModel on Model implements ConnectedModels {
  Future<Null> fetchData() {
    isLoading = true;
    notifyListeners();
    return http
        .get('https://flutter-products-b7b5f.firebaseio.com/products.json')
        .then((http.Response response) {
      final List<Product> fetchedProducts = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      if (productListData == null) {
        isLoading = false;
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          image: productData['image'],
          price: productData['price'],
          email: productData['email'],
          userId: productData['userId'],
        );
        fetchedProducts.add(product);
      });
      _products = fetchedProducts;
      isLoading = false;
      notifyListeners();
    });
  }

  bool _switchFavourites = false;

  void toggleFavouritesSwitch() {
    _switchFavourites = !_switchFavourites;
    notifyListeners();
  }

  bool get toggleFavourites {
    return _switchFavourites;
  }

  List<Product> get displayFavouriteProducts {
    if (_switchFavourites) {
      return List.from(
          _products.where((Product product) => product.isFavourite));
    } else {
      return List.from(_products);
    }
  }

  Future<bool> deleteProduct(int index) {
    isLoading = true;
    notifyListeners();
    return http
        .delete(
            'https://flutter-products-b7b5f.firebaseio.com/products/${_products[index].id}.json')
        .then((http.Response response) {
      _products.removeAt(index);
      isLoading = false;
      notifyListeners();
      return true;
    }).catchError((onError) {
      isLoading = false;
      return false;
    });
  }
}

mixin UserModel on Model implements ConnectedModels {}
