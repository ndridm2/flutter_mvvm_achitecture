import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../utils/routes/routes_name.dart';
import '../user_view_model.dart';

class SplashService {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuth(BuildContext context) async {
    try {
      final navigator = Navigator.of(context);
      final userData = await getUserData();

      if (kDebugMode) {
        print(userData.token.toString());
      }

      if (userData.token.toString() == 'null' ||
          userData.token.toString() == '') {
        await Future.delayed(const Duration(seconds: 3));
        navigator.pushNamed(RoutesName.login);
      } else {
        await Future.delayed(const Duration(seconds: 3));
        navigator.pushNamed(RoutesName.home);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }
}

class RoutesNanme {}
