import 'package:shared_preferences/shared_preferences.dart';

class PrefController {

  ///save logged in user details to prefs
  static setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  static getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "";
  }



  ///clears logged in user data from
  static clearUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
}