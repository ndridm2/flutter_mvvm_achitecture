import 'package:mvvm/data/network/base_api_services.dart';
import 'package:mvvm/data/network/network_api_service.dart';
import 'package:mvvm/models/randomuser_model.dart';
import 'package:mvvm/res/app_url.dart';

class RandomuserRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<RandomuserListModel> fetchRandomuserList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.randomUser);
      return response = RandomuserListModel.fromMap(response);
    } catch (e) {
      rethrow;
    }
  }
}
