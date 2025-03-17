import 'package:dartz/dartz.dart';
import 'package:saturn/core/networking/api_service.dart';
import 'package:saturn/core/networking/server_exception.dart';
import 'package:saturn/features/add%20post/data/models/add_post_request_model.dart';
import 'package:saturn/features/add%20post/data/models/add_post_response_model.dart';

class AddPostRepo {
  final ApiService _apiService;

  AddPostRepo({required ApiService apiService}) : _apiService = apiService;
  Future<Either<String, AddPostResponseModel>> addPost(
    AddPostRequestModel addPostRequestModel,
  ) async {
    try {
      final AddPostResponseModel addPostResponseModel = await _apiService
          .addPost(addPostRequestModel);
      return right(addPostResponseModel);
    } on ServerException catch (e) {
      return left(e.apiErrorModel.message);
    }
  }
}
