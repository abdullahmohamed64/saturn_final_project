import 'package:dartz/dartz.dart';
import 'package:saturn/core/networking/api_service.dart';
import 'package:saturn/core/networking/server_exception.dart';
import 'package:saturn/features/home/data/models/art_model.dart';
import 'package:saturn/features/home/data/models/categorys_response_model.dart';

class HomeRepo {
  final ApiService _apiService;

  HomeRepo({required ApiService apiService}) : _apiService = apiService;
  Future<Either<List<ArtModel>, String>> getCategoryItems({
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
}
