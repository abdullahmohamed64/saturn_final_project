import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:saturn/core/networking/api_constants.dart';

class DioFactory {
  /// to prevent take an object
  DioFactory._();
  static Dio? dio;
  static Duration timeOut = const Duration(seconds: 30);
  static Dio getDio() {
    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      //  addHeaders();
      addDioInterceptors();
      
       dio?.options.baseUrl = ApiConstants.baseUrl;
    }
    return dio!;
  }

  // static void addHeaders()async {

  //   String token = await SharedPrefHelper.getSecuredData(SharedPrefKeys.userTokenKey);
  //   dio?.options.headers = {
  //     'Accept': 'application/json',
  //     'Authorization':
  //         'Bearer $token',
  //   };
  // }
  static void addTokenAfterLogin({required String token}) {
    dio?.options.headers = {'Authorization': 'Bearer $token'};

  }

  static void addDioInterceptors() {
    //?. If the object is null, the expression will return null without throwing an error.
    //If dio is null, the expression does nothing (no logging interceptor is added), and no exception is thrown.
    dio?.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ),
      
    );
   
  }
}
