import 'package:dartz/dartz.dart';
import 'package:saturn/core/networking/api_service.dart';
import 'package:saturn/core/networking/server_exception.dart';
import 'package:saturn/features/auth/models/user_model.dart';
import 'package:saturn/features/profile/data/models/edit_user_model.dart';

class EditUserRepo {
  final ApiService _apiService;

  EditUserRepo({required ApiService apiService}) : _apiService = apiService;
  Future<Either<String, EditUserResposeModel>> editUserProfile(
    UserModel userModel,
  ) async {
    try {
      final res = await _apiService.editUserProfile(userModel);
      return right(res);
    } on ServerException catch (e) {
      return left(e.apiErrorModel.message);
    }
  }
}
