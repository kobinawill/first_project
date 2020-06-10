import 'dart:convert';

import 'package:first_project/controllers/pref_controller.dart';
import 'package:first_project/models/product.dart';
import 'package:first_project/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainModel extends Model with ConnectedModels, ProductModel, UserModel {}

mixin ConnectedModels on Model {
  List<Product> _products = [];
  bool isLoading = false;
  User _authenticatedUser;
  String authenticatedUserToken = '';


  Future<Map<String, dynamic>> login(String email, String password) async {
    isLoading = true;
    notifyListeners();
    Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final http.Response response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAoOEBYyfBu5oOE_raQMeMClk4KP51kTo8',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> checkData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went wrong';
    if (checkData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded!';
      await PrefController.setToken(checkData['idToken']);
      _authenticatedUser = new User(
          userId: checkData['localId'],
          email: email,
          token: checkData['idToken']);
      authenticatedUserToken = checkData['idToken'];
     // print('$checkData');

    } else if (checkData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'Email was not found';
    } else if(checkData['error']['message'] == 'INVALID_PASSWORD'){
      message = 'Password Invalid';
    }
    isLoading = false;
    notifyListeners();
    /*print('token: ${_authenticatedUser.token}');
    print('email: ${_authenticatedUser.email}');
    print('userId: ${_authenticatedUser.userId}');*/
    return {'success': !hasError, 'message': message};
  }

  Future<Map<String, dynamic>> signUp(String email, String password) async {
    isLoading = true;
    notifyListeners();
    Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    /*print('token: ${_authenticatedUser.token}');
    print('email: ${_authenticatedUser.email}');
    print('userId: ${_authenticatedUser.userId}');*/

    http.Response response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAoOEBYyfBu5oOE_raQMeMClk4KP51kTo8',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> checkData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went wrong';
    if (checkData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded!';
      await PrefController.setToken(checkData['idToken']);
      _authenticatedUser = new User(
          userId: checkData['localId'],
          email: checkData['email'],
          token: checkData['idToken']
      );
      authenticatedUserToken = checkData['idToken'];
      //print('$checkData');
    } else if (checkData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'Email Already exists';
    }
    isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }


  List<Product> get products {
    return List.from(_products);
  }

  Future<bool> addProducts(
      String title, String description, String image, double price) async {
    isLoading = true;
    notifyListeners();

    Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://cdn.pixabay.com/photo/2015/10/02/12/00/chocolate-968457_960_720.jpg',
      'price': price,
      'email': _authenticatedUser.email,
      'userId': _authenticatedUser.userId,
      'userToken': _authenticatedUser.token
    };

    String token = await PrefController.getToken();
    //print('TOKEN FROM ADDPRODUCT: $token');
    //print('token $token');

    return http
        .post('https://flutter-products-b7b5f.firebaseio.com/products.json?auth=$token',
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
        userToken: _authenticatedUser.token
      ));
      isLoading = false;
      return true;
    });
  }

  Future<Null> updateProduct(
      int index, String title, String description, String image, double price) async {
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
      'userToken': _authenticatedUser.token
    };
    String token = await PrefController.getToken();

    return http
        .put(
            'https://flutter-products-b7b5f.firebaseio.com/products/${_products[index].id}.json?auth=$token',
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
        userToken: _products[index].userToken
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
        userToken: _products[index].userToken,
        isFavourite: newFavourite);
    _products[index] = updatedProduct;
    notifyListeners();
  }

  bool get nowLoading => isLoading;
}

mixin ProductModel on Model implements ConnectedModels {
  Future<Null> fetchData() async {
    isLoading = true;
    notifyListeners();
    String token = await PrefController.getToken();
    //print('TOKEN FROM FETCHDATA: $token');
    //print('token $token');

    return http
        .get('https://flutter-products-b7b5f.firebaseio.com/products.json?auth=$token')
        .then((http.Response response) {
      final List<Product> fetchedProducts = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
          //print('api data');
          //print('PRODUCT DATA HERE: $productListData');
      if (productListData == null) {
        isLoading = false;
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {

        final Product product = Product(
          id: productId,
          title: '${productData['title']}',
          description: '${productData['description']}',
          image: '${productData['image']}',
          price: productData['price'],
          email: '${productData['email']}',
          userId: '${productData['userId']}',
          userToken: '${productData['userToken']}'
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

  Future<bool> deleteProduct(int index) async {
    isLoading = true;
    notifyListeners();

    String token = await PrefController.getToken();

    return http
        .delete(
            'https://flutter-products-b7b5f.firebaseio.com/products/${_products[index].id}.json?auth=$token')
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

mixin UserModel on Model implements ConnectedModels {

}
