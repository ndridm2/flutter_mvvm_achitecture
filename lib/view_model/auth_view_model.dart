import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/models/user_model.dart';
import 'package:mvvm/repositories/auth_repository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _registerLoading = false;
  bool get registerLoading => _registerLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setRegisterLoading(bool value) {
    _registerLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    try {
      // Ambil navigator dan userPref sebelum async
      final navigator = Navigator.of(context);
      final userPref = Provider.of<UserViewModel>(context, listen: false);

      // Operasi async
      await Future.delayed(const Duration(seconds: 1));
      final response = await _myRepo.loginApi(data);

      // Ambil token dari respons
      final token = response['token'];
      if (token == null) {
        throw Exception("Token is null in the response");
      }

      // Simpan token ke UserViewModel
      userPref.saveUser(UserModel(token: token));

      // login success
      setLoading(false);
      Utils.toastMessage('Login success');

      // Navigation to page
      navigator.pushNamed(RoutesName.home);

      if (kDebugMode) {
        print(response.toString());
      }
    } catch (error) {
      // error handling
      setLoading(false);
      if (context.mounted) {
        Utils.flushBarErrorMessage(error.toString(), context);
      }

      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

  Future<void> registerApi(dynamic data, BuildContext context) async {
    final navigator = Navigator.of(context);

    setRegisterLoading(true);

    try {
      // Operasi async
      await Future.delayed(const Duration(seconds: 1));
      final response = await _myRepo.registerApi(data);

      // login success
      setRegisterLoading(false);
      Utils.toastMessage('Register success');

      // Navigation to page
      navigator.pushNamed(RoutesName.login);

      if (kDebugMode) {
        print(response.toString());
      }
    } catch (error) {
      // error handling
      setRegisterLoading(false);
      if (context.mounted) {
        Utils.flushBarErrorMessage(error.toString(), context);
      }

      if (kDebugMode) {
        print(error.toString());
      }
    }
  }
}
