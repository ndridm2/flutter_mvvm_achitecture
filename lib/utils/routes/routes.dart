import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/detail_page.dart';
import 'package:mvvm/view/home_page.dart';
import 'package:mvvm/view/login_page.dart';
import 'package:mvvm/view/register_page.dart';
import 'package:mvvm/view/splashscreen_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashscreenPage());
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomePage());
      case RoutesName.detail:
        final int userId = settings.arguments as int;
        return MaterialPageRoute(
            builder: (BuildContext context) => DetailPage(
                  userId: userId,
                ));
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginPage());
      case RoutesName.register:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegisterPage());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
