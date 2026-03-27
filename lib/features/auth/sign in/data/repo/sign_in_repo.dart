import 'package:dartz/dartz.dart';
import 'package:saturn/core/networking/api_service.dart';
import 'package:saturn/core/networking/server_exception.dart';
import 'package:saturn/features/auth/sign%20in/data/models/sign_in_request_model.dart';
import 'package:saturn/features/auth/sign%20in/data/models/sign_in_response_model.dart';

class SignInRepo {
  final ApiService _apiService;

  SignInRepo({required ApiService apiService}) : _apiService = apiService;

  Future<Either<SignInResponseModel, String>> signIn(
    SignInRequestModel signInRequestModel,
  ) async {
    try {
      SignInResponseModel res = await _apiService.sinIn(signInRequestModel);
      return left(res);
    } on ServerException catch (e) {
      return right(e.apiErrorModel.message);
    }
  }
}

// repo retrun left and  right
