import 'package:dartz/dartz.dart';
import 'package:saturn/core/networking/api_service.dart';
import 'package:saturn/core/networking/server_exception.dart';
import 'package:saturn/features/auth/models/user_model.dart';
import 'package:saturn/features/chat/data/models/users_list_model.dart';
import 'package:saturn/features/home/data/models/art_model.dart';
import 'package:saturn/features/home/data/models/categorys_response_model.dart';

class HomeRepo {
  final ApiService _apiService;

  HomeRepo({required ApiService apiService}) : _apiService = apiService;
  Future<Either<List<PostModel>, String>> getCategoryItems({
    String? categoryName,
  }) async {
    try {
      final CategorysResponseModel res = await _apiService.getCategoryItems(
        categoryName: categoryName,
      );

      return left(res.arts);
    } on ServerException catch (e) {
      return right(e.apiErrorModel.message);
    }
  }

  Future<Either<List<UserModel>, String>> getAllUsers() async {
    try {
      final UsersListModel res = await _apiService.getAllUsers();

      return left(res.users!);
    } on ServerException catch (e) {
      return right(e.apiErrorModel.message);
    }
  }
}
