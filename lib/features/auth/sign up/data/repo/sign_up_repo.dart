import 'package:dartz/dartz.dart';
import 'package:saturn/core/networking/api_service.dart';
import 'package:saturn/core/networking/server_exception.dart';
import 'package:saturn/features/auth/sign%20up/data/models/sign_up_request_model.dart';
import 'package:saturn/features/auth/sign%20up/data/models/sign_up_response_model.dart';

class SignUpRepo {
  final ApiService apiService;
  SignUpRepo({required this.apiService});
  Future<Either<SignUpResponseModel, String>> signUp(
    SignUpRequestModel signUpRequestModel,
  ) async {
    try {
      SignUpResponseModel res = await apiService.signUp(signUpRequestModel);
      return Left(res);
    } on ServerException catch (e) {
      return Right(e.apiErrorModel.message);
    }
  }
}


//dioFactory => return dio 
//api service use dio to make functions like sign in and sign up 
//repo take the result from fuction and pass it to cubit 
//cubit send states to ui