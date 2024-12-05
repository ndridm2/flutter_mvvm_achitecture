import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final userPref = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        actions: [
          InkWell(
            onTap: () async {
              try {
                await userPref.remove();
                if (context.mounted) {
                  Navigator.pushNamed(context, RoutesName.login);
                }
              } catch (error) {
                if (kDebugMode) {
                  print("Error during logout: $error");
                }
              }
            },
            child: const Center(
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Center(
        child: InkWell(
          onTap: () {},
          child: const Text('MVVM'),
        ),
      ),
    );
  }
}
