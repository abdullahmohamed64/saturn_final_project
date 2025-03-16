import 'package:dartz/dartz.dart';
import 'package:saturn/core/networking/api_service.dart';
import 'package:saturn/core/networking/server_exception.dart';
import 'package:saturn/features/favourite/data/models/add_like_response_model.dart';

class FavouriteRepo {
  final ApiService _apiService;

  FavouriteRepo({required ApiService apiService}) : _apiService = apiService;
  Future<Either<AddLikeResponseModel, String>> react({
    required int artId,
  }) async {
    try {
      final AddLikeResponseModel addLikeResponseModel = await _apiService.react(
        artId: artId,
      );
      return left(addLikeResponseModel);
    } on ServerException catch (e) {
      return right(e.apiErrorModel.message);
    }
  }
}
