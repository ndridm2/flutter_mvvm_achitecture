import 'package:flutter/material.dart';

import '../view_model/services/splash_service.dart';

class SplashscreenPage extends StatefulWidget {
  const SplashscreenPage({super.key});

  @override
  State<SplashscreenPage> createState() => _SplashscreenPageState();
}

class _SplashscreenPageState extends State<SplashscreenPage> {
  SplashService splashService = SplashService();

  @override
  void initState() {
    super.initState();
    splashService.checkAuth(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text("MVVM"),
    ));
  }
}
