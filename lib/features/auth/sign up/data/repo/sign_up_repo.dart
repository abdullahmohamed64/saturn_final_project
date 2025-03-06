import 'package:saturn/core/networking/api_error_handler.dart';

import 'package:saturn/core/networking/api_result.dart';
import 'package:saturn/core/networking/api_service.dart';
import 'package:saturn/features/auth/sign%20up/data/models/sign_up_request_model.dart';
import 'package:saturn/features/auth/sign%20up/data/models/sign_up_response_model.dart';

class SignUpRepo {
  final ApiService apiService;
  SignUpRepo({required this.apiService});
  Future<ApiResult<SignUpResponseModel>> signUp(SignUpRequestModel signUpRequestModel)async {
    try {
      final res = await apiService.signUp(signUpRequestModel);
      return ApiResult.success(res);
    } catch (e) {
      
      return ApiResult.failure(ErrorHandler.handle(e));
      
    }
  }
}


//dioFactory => return dio 
//api service use dio to make functions like sign in and sign up 
//repo take the result from fuction and pass it to cubit 
//cubit send states to ui