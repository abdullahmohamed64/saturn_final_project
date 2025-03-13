// import 'package:dio/dio.dart';
// import 'package:retrofit/retrofit.dart';
// import 'package:saturn/core/networking/api_constants.dart';
// import 'package:saturn/features/auth/sign%20up/data/models/sign_up_request_model.dart';
// import 'package:saturn/features/auth/sign%20up/data/models/sign_up_response_model.dart';
// part 'api_service.g.dart';

// //The @RestApi annotation tells Retrofit that this interface is a REST API client. The base URL is provided by ApiConstants.baseUrl
// @RestApi(baseUrl: ApiConstants.baseUrl)
// abstract class ApiService {
//   factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

//   @POST(ApiConstants.signUp)
//   Future<SignUpResponseModel> signUp(
//     @Body() SignUpRequestModel signUpRequestModel,
//   );
// }

import 'package:saturn/core/helper/app_functions.dart';
import 'package:saturn/core/helper/shared_pref_helper.dart';
import 'package:saturn/core/helper/shared_pref_keys.dart';
import 'package:saturn/core/networking/api%20consumer/api_consumer.dart';

import 'package:saturn/core/networking/api_constants.dart';
import 'package:saturn/core/networking/server_exception.dart';
import 'package:saturn/features/auth/sign%20in/data/models/sign_in_request_model.dart';
import 'package:saturn/features/auth/sign%20in/data/models/sign_in_response_model.dart';

import 'package:saturn/features/auth/sign%20up/data/models/sign_up_request_model.dart';
import 'package:saturn/features/auth/sign%20up/data/models/sign_up_response_model.dart';
import 'package:saturn/features/favourite/data/models/add_like_response_model.dart';
import 'package:saturn/features/home/data/models/categorys_response_model.dart';

class ApiService {
  ApiService({required this.api});
  final ApiConsumer api;

  Future<SignUpResponseModel> signUp(
    SignUpRequestModel signUpRequestModel,
  ) async {
    final data = {
      'username': signUpRequestModel.username,
      'email': signUpRequestModel.email,
      'password': signUpRequestModel.password,
      'mobile': signUpRequestModel.mobile,
      'birthdate': signUpRequestModel.birthdate,
      'gender': signUpRequestModel.gender,
      'bio': signUpRequestModel.bio,
      // For files, use MultipartFile:
      'file':
          signUpRequestModel.imagePath != null
              ? await AppFunctions.uploadImageToApiMethod(
                signUpRequestModel.imagePath,
              )
              : null,
    };

    try {
      final res = await api.post(
        ApiConstants.signUp,
        data: data,
        isFromData: true,
      );

      return SignUpResponseModel.fromJson(res);
    } on ServerException catch (e) {
      throw ServerException(apiErrorModel: e.apiErrorModel);
    }
  }

  // i added baseUrl to diio factory
  Future<SignInResponseModel> sinIn(
    SignInRequestModel signInRequestModel,
  ) async {
    final data = {
      'email': signInRequestModel.email,
      'password': signInRequestModel.password,
    };
    try {
      final res = await api.post(
        ApiConstants.signIn,
        data: data,
        isFromData: true,
      );
      return SignInResponseModel.fromJson(res);
    } on ServerException catch (e) {
      throw ServerException(apiErrorModel: e.apiErrorModel);
    }
  }

  Future<CategorysResponseModel> getCategoryItems({
    String? categoryName,
  }) async {
    final param = {
      'category': categoryName ?? '',
      'token': await SharedPrefHelper.getSecuredData(SharedPrefKeys.tokenKey),
      'userid': await SharedPrefHelper.getInt(SharedPrefKeys.userIdKey),
    };
    try {
      final res = await api.get(
        ApiConstants.getCategorieItems,
        queryParameters: param,
        // data: data,
        // isFromData: true,
      );
      return CategorysResponseModel.fromJson(res);
    } on ServerException catch (e) {
      throw ServerException(apiErrorModel: e.apiErrorModel);
    }
  }

  Future<AddLikeResponseModel> react({required int artId}) async {
    Map<String, dynamic> data = {
      'userid': await SharedPrefHelper.getInt(SharedPrefKeys.userIdKey),
      'token': await SharedPrefHelper.getSecuredData(SharedPrefKeys.tokenKey),
      'postid': artId,
    };
    try {
      final res = await api.post(
        ApiConstants.addLike,
        data: data,
        isFromData: true,
      );
      return AddLikeResponseModel.fromJson(res);
    } on ServerException catch (e) {
      throw ServerException(apiErrorModel: e.apiErrorModel);
    }
  }
}
