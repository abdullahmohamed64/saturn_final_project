import 'package:dartz/dartz.dart';
import 'package:saturn/core/networking/api_service.dart';
import 'package:saturn/core/networking/server_exception.dart';
import 'package:saturn/features/profile/data/models/user_profile_response_model.dart';

class UserProfileRepo {
  final ApiService _apiService;

  UserProfileRepo({required ApiService apiService}) : _apiService = apiService;



  Future<Either<String , UserProfileResponseModel>> getUserProfile()async {
  try {
     final result = await  _apiService.getUserProfile();
     return right(result);
  } 
  on ServerException catch (e) {
    return left(e.apiErrorModel.message);
  }
}
}