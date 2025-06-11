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
import 'package:saturn/features/add%20post/data/models/add_post_request_model.dart';
import 'package:saturn/features/add%20post/data/models/add_post_response_model.dart';
import 'package:saturn/features/auth/models/user_model.dart';
import 'package:saturn/features/auth/sign%20in/data/models/sign_in_request_model.dart';
import 'package:saturn/features/auth/sign%20in/data/models/sign_in_response_model.dart';

import 'package:saturn/features/auth/sign%20up/data/models/sign_up_request_model.dart';
import 'package:saturn/features/auth/sign%20up/data/models/sign_up_response_model.dart';
import 'package:saturn/features/chat/data/models/users_list_model.dart';
import 'package:saturn/features/favourite/data/models/user_favourit_arts_model.dart';
import 'package:saturn/features/home/data/models/art_model.dart';
import 'package:saturn/features/home/data/models/categorys_response_model.dart';
import 'package:saturn/features/profile/data/models/edit_user_model.dart';
import 'package:saturn/features/profile/data/models/user_profile_response_model.dart';

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

  Future<ArtModel> makeReact({required int artId}) async {
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
      return ArtModel.fromJson(res);
    } on ServerException catch (e) {
      throw ServerException(apiErrorModel: e.apiErrorModel);
    }
  }

  Future<ArtModel> createComment({
    required int artId,
    required String comment,
  }) async {
    Map<String, dynamic> data = {
      'userid': await SharedPrefHelper.getInt(SharedPrefKeys.userIdKey),
      'token': await SharedPrefHelper.getSecuredData(SharedPrefKeys.tokenKey),
      'postid': artId,
      'comment': comment,
    };
    try {
      final res = await api.post(
        ApiConstants.addComment,
        data: data,
        isFromData: true,
      );
      return ArtModel.fromJson(res);
    } on ServerException catch (e) {
      throw ServerException(apiErrorModel: e.apiErrorModel);
    }
  }

  Future<ArtModel> getPostReactAndComments({required int artId}) async {
    Map<String, dynamic> data = {
      'userid': await SharedPrefHelper.getInt(SharedPrefKeys.userIdKey),
      'token': await SharedPrefHelper.getSecuredData(SharedPrefKeys.tokenKey),
      'postid': artId,
    };
    try {
      final res = await api.post(
        ApiConstants.likedPosts,
        data: data,
        isFromData: true,
      );
      return ArtModel.fromJson(res);
    } on ServerException catch (e) {
      throw ServerException(apiErrorModel: e.apiErrorModel);
    }
  }

  Future<UserFavouritArtsModel> getUserFavoriteArts() async {
    Map<String, dynamic> data = {
      'userid': await SharedPrefHelper.getInt(SharedPrefKeys.userIdKey),
      'token': await SharedPrefHelper.getSecuredData(SharedPrefKeys.tokenKey),
    };
    try {
      final res = await api.get(ApiConstants.favorites, queryParameters: data);
      return UserFavouritArtsModel.fromJson(res);
    } on ServerException catch (e) {
      throw ServerException(apiErrorModel: e.apiErrorModel);
    }
  }

  Future<AddPostResponseModel> addPost(
    AddPostRequestModel addPostRequestModel,
  ) async {
    final data = {
      'userid': await SharedPrefHelper.getInt(SharedPrefKeys.userIdKey),
      'token': await SharedPrefHelper.getSecuredData(SharedPrefKeys.tokenKey),
      'description': addPostRequestModel.description,
      'category': addPostRequestModel.categoryName,

      'type': addPostRequestModel.type,

      // For files, use MultipartFile:
      'file':
          addPostRequestModel.imagePath != null
              ? await AppFunctions.uploadImageToApiMethod(
                addPostRequestModel.imagePath,
              )
              : null,
    };

    try {
      final res = await api.post(
        ApiConstants.addPost,
        data: data,
        isFromData: true,
      );

      return AddPostResponseModel.fromJson(res);
    } on ServerException catch (e) {
      throw ServerException(apiErrorModel: e.apiErrorModel);
    }
  }

  Future<UserProfileResponseModel> getUserProfile() async {
    Map<String, dynamic> data = {
      'userid': await SharedPrefHelper.getInt(SharedPrefKeys.userIdKey),
      'token': await SharedPrefHelper.getSecuredData(SharedPrefKeys.tokenKey),
    };
    try {
      final res = await api.get(
        ApiConstants.userProfile,
        queryParameters: data,
      );
      return UserProfileResponseModel.fromJson(res);
    } on ServerException catch (e) {
      throw ServerException(apiErrorModel: e.apiErrorModel);
    }
  }

  Future<UsersListModel> getAllUsers() async {
    Map<String, dynamic> data = {
      'userid': await SharedPrefHelper.getInt(SharedPrefKeys.userIdKey),
      'token': await SharedPrefHelper.getSecuredData(SharedPrefKeys.tokenKey),
    };
    try {
      final res = await api.get(
        ApiConstants.getAllUsersUrl,
        queryParameters: data,
      );
      return UsersListModel.fromJson(res);
    } on ServerException catch (e) {
      throw ServerException(apiErrorModel: e.apiErrorModel);
    }
  }

  Future<EditUserResposeModel> editUserProfile(UserModel userModel) async {
    final data = {
      'mobile': userModel.mobile,
      'username': userModel.username,
      'email': userModel.email,
      'bio': userModel.bio,
      'pic_name':        userModel.imagePath != null
              ? await AppFunctions.uploadImageToApiMethod(
                userModel.imagePath              )
              : null,
      'password': userModel.password,
    };
    final queryParameters = {
      'userid':await SharedPrefHelper.getInt(SharedPrefKeys.userIdKey),
      'token': await SharedPrefHelper.getSecuredData(SharedPrefKeys.tokenKey),
    };
    try {
      final res = await api.post(
        ApiConstants.editUser,
        data: data,
        isFromData: true,
        queryParameters: queryParameters,
      );
      return EditUserResposeModel.fromJson(res);
    } on ServerException catch (e) {
      throw ServerException(apiErrorModel: e.apiErrorModel);
    }
  }
}
