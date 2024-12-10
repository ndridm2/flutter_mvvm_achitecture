import 'package:flutter/material.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/models/randomuser_model.dart';
import 'package:mvvm/repositories/randomuser_repository.dart';

class RandomuserViewModel with ChangeNotifier {
  final _myRepo = RandomuserRepository();

  ApiResponse<RandomuserListModel> randomuserList = ApiResponse.loading();

  setRandomuserList(ApiResponse<RandomuserListModel> response) {
    randomuserList = response;
    notifyListeners();
  }

  Future<void> fetchRandomuserListApi() async {
    setRandomuserList(ApiResponse.loading());
    _myRepo.fetchRandomuserList().then((value) {
      setRandomuserList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setRandomuserList(ApiResponse.error(error.toString()));
    });
  }
}
