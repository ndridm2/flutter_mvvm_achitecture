import 'package:flutter/material.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/models/randomsingle_model.dart';
import 'package:mvvm/models/randomuser_model.dart';
import 'package:mvvm/repositories/randomuser_repository.dart';

class RandomuserViewModel with ChangeNotifier {
  final RandomuserRepository _repository = RandomuserRepository();

  // API Response for Randomuser List
  ApiResponse<RandomuserListModel> _randomuserList = ApiResponse.loading();
  ApiResponse<RandomuserListModel> get randomuserList => _randomuserList;

  void _setRandomuserList(ApiResponse<RandomuserListModel> response) {
    _randomuserList = response;
    notifyListeners();
  }

  Future<void> fetchRandomuserList() async {
    _setRandomuserList(ApiResponse.loading());
    try {
      final data = await _repository.fetchRandomuserList();
      _setRandomuserList(ApiResponse.completed(data));
    } catch (error) {
      _setRandomuserList(ApiResponse.error(error.toString()));
    }
  }

  // API Response for Single Randomuser
  ApiResponse<RandomuserModel> _randomuser = ApiResponse.loading();
  ApiResponse<RandomuserModel> get randomuser => _randomuser;

  void _setRandomuser(ApiResponse<RandomuserModel> response) {
    _randomuser = response;
    notifyListeners();
  }

  Future<void> fetchRandomuser(int id) async {
    _setRandomuser(ApiResponse.loading());
    try {
      final data = await _repository.fetchRandomuser(id);
      _setRandomuser(ApiResponse.completed(data));
    } catch (error) {
      _setRandomuser(ApiResponse.error(error.toString()));
    }
  }
}
