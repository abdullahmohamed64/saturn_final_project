import 'package:dartz/dartz.dart';
import 'package:saturn/core/networking/api_service.dart';
import 'package:saturn/core/networking/server_exception.dart';
import 'package:saturn/features/favourite/data/models/favorite_model.dart';

class FavouriteRepo {
  final ApiService _apiService;

  FavouriteRepo({required ApiService apiService}) : _apiService = apiService;
  Future<Either<FavoriteModel, String>> react({
    required int artId,
  }) async {
    try {
      final FavoriteModel addLikeResponseModel = await _apiService
          .react(artId: artId);
      return left(addLikeResponseModel);
    } on ServerException catch (e) {
      return right(e.apiErrorModel.message);
    }
  }

  Future<Either<FavoriteModel, String>> getPostReact({
    required int artId,
  }) async {
    try {
      final FavoriteModel getPostReactResponseModel =
          await _apiService.getPostReact(artId: artId);
      return left(getPostReactResponseModel);
    } on ServerException catch (e) {
      return right(e.apiErrorModel.message);
    }
  }
}
