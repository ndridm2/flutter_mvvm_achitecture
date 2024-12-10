import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/randomuser_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RandomuserViewModel randomuserViewModel = RandomuserViewModel();

  @override
  void initState() {
    super.initState();
    randomuserViewModel.fetchRandomuserListApi();
  }

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
      body: ChangeNotifierProvider<RandomuserViewModel>(
        create: (BuildContext context) => randomuserViewModel,
        child: Consumer<RandomuserViewModel>(
          builder: (context, value, _) {
            switch (value.randomuserList.status) {
              case null:
                return const Center(child: CircularProgressIndicator());
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
              case Status.completed:
                return ListView.builder(
                  itemCount: value.randomuserList.data!.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              value.randomuserList.data!.data![index].avatar
                                  .toString(),
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
                                );
                              },
                            ),
                          ),
                          title: Text(value
                              .randomuserList.data!.data![index].email
                              .toString()),
                          subtitle: Text(value
                              .randomuserList.data!.data![index].fullName
                              .toString()),
                        ),
                      ),
                    );
                  },
                );
              case Status.error:
                return Center(
                  child: Text(
                    value.randomuserList.message.toString(),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
