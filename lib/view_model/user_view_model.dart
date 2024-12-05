import 'package:flutter/material.dart';
import 'package:mvvm/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', user.token.toString());
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? token = pref.getString('token');

    return UserModel(
      token: token.toString(),
    );
  }

  Future<bool> remove() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('token');
    return true;
  }
}
