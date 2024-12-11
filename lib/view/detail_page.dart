import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/view_model/randomuser_view_model.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  final int userId;

  const DetailPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final RandomuserViewModel viewModel = RandomuserViewModel();
    viewModel.fetchRandomuser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider<RandomuserViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<RandomuserViewModel>(
          builder: (context, value, _) {
            final apiResponse = value.randomuser;

            switch (value.randomuser.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
              case Status.completed:
                final user = apiResponse.data?.data;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(user?.avatar ?? ''),
                        onBackgroundImageError: (_, __) => const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user?.fullName ?? 'No Name',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user?.email ?? 'No Email',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              case Status.error:
                return Center(
                  child: Text(apiResponse.message ?? 'Error occurred'),
                );
              default:
                return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
