import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/widgets/rotating_text_widget.dart';
import 'package:mvvm/view_model/randomuser_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RandomuserViewModel viewModel = RandomuserViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.fetchRandomuserList();
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
            borderRadius: BorderRadius.circular(8.0),
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
        create: (BuildContext context) => viewModel,
        child: Consumer<RandomuserViewModel>(
          builder: (context, value, _) {
            final apiResponse = value.randomuserList;

            switch (value.randomuserList.status) {
              case null:
              case Status.loading:
                return ListView.builder(
                  itemCount: 6, // Jumlah placeholder shimmer
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 8.0),
                      child: Card(
                        child: ListTile(
                          leading: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 50,
                              height: 50,
                              color: Colors.white,
                            ),
                          ),
                          title: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              case Status.completed:
                final randomUsers = apiResponse.data?.data ?? [];
                return ListView.builder(
                  itemCount: randomUsers.length,
                  itemBuilder: (context, index) {
                    final user = randomUsers[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 8.0),
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RoutesName.detail,
                              arguments: user.id,
                            );
                          },
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                user.avatar ?? '',
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                            ),
                            title: Text(user.email ?? 'No Email'),
                            subtitle: Text(user.fullName),
                          ),
                        ),
                      ),
                    );
                  },
                );
              case Status.error:
                return Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.minWidth,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: RotatingTextWidget(
                                      text: value.randomuserList.message
                                          .toString(),
                                      radius: 100.0,
                                      textStyle: const TextStyle(
                                          fontSize: 18, color: Colors.blue),
                                      rotationDuration:
                                          const Duration(seconds: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
