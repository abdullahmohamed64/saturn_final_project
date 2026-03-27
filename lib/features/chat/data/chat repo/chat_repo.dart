import 'package:dartz/dartz.dart';
import 'package:saturn/core/networking/api_service.dart';
import 'package:saturn/core/networking/server_exception.dart';
import 'package:saturn/features/auth/models/user_model.dart';
import 'package:saturn/features/chat/data/models/users_list_model.dart';

class ChatRepo {
  final ApiService _apiService;

  ChatRepo({required ApiService apiService}) : _apiService = apiService;
  Future<Either<List<UserModel>, String>> getAllUsers() async {
    try {
      final UsersListModel res = await _apiService.getAllUsers();

      return left(res.users!);
    } on ServerException catch (e) {
      return right(e.apiErrorModel.message);
    }
  }
}
