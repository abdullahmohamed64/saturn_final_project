import 'package:dartz/dartz.dart';
import 'package:saturn/core/networking/api_service.dart';
import 'package:saturn/core/networking/server_exception.dart';
import 'package:saturn/features/favourite/data/models/user_favourit_arts_model.dart';
import 'package:saturn/features/home/data/models/art_model.dart';

class FavouriteRepo {
  final ApiService _apiService;

  FavouriteRepo({required ApiService apiService}) : _apiService = apiService;

  Future<Either<String, ArtModel>> makeReact({required int artId}) async {
    try {
      final ArtModel addLikeResponseModel = await _apiService.makeReact(
        artId: artId,
      );

      return right(addLikeResponseModel);
    } on ServerException catch (e) {
      return left(e.apiErrorModel.message);
    }
    // catch (e) {
    //   return left("failed to make react ${e.toString()}");
    // }
  }

  Future<Either<String, ArtModel>> createComment({
    required int artId,
    required String comment,
  }) async {
    try {
      final ArtModel createCommentResponseModel = await _apiService
          .createComment(artId: artId, comment: comment);

      return right(createCommentResponseModel);
    } on ServerException catch (e) {
      return left(e.apiErrorModel.message);
    }
    //  catch (e) {
    //   return left("failed to create comment ${e.toString()}");
    // }
  }

  Future<Either<String, ArtModel>> getPostReactAndComments({
    required int artId,
  }) async {
    try {
      final ArtModel getPostReactResponseModel = await _apiService
          .getPostReactAndComments(artId: artId);
      return right(getPostReactResponseModel);
    } on ServerException catch (e) {
      return left(e.apiErrorModel.message);
    }

    // catch (e) {
    //   return left("failed to get post react and comments ${e.toString()}");
    // }
  }

  Future<Either<String, UserFavouritArtsModel>> getUserFavoriteArts() async {
    try {
      final UserFavouritArtsModel getPostReactResponseModel =
          await _apiService.getUserFavoriteArts();
      return right(getPostReactResponseModel);
    } 
    on ServerException catch (e) {
      return left(e.apiErrorModel.message);
    }

    // catch (e) {
    //   return left("failed to get post react and comments ${e.toString()}");
    // }
  }
}
