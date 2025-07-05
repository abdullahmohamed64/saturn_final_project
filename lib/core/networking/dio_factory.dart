import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:saturn/core/helper/check_internet.dart';
import 'package:saturn/core/helper/shared_pref_helper.dart';
import 'package:saturn/core/helper/shared_pref_keys.dart';
import 'package:saturn/core/networking/api_constants.dart';

class DioFactory {
  /// to prevent take an object
  DioFactory._();


  static Dio? dio;
  static Duration timeOut = const Duration(seconds: 30);
  static Dio getDio()  {
    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      //  addHeaders();
      addDioInterceptors();

    ApiConstants.getBaseUrl().then((value) => dio!.options.baseUrl = value);
    }
    return dio!;
  }

  static void addHeaders() async {
    String token = await SharedPrefHelper().getSecuredData(
      SharedPrefKeys.tokenKey,
    );
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  static void addTokenAfterLogin({required String token}) {
    dio?.options.headers = {'Authorization': 'Bearer $token'};
  }

  static void addDioInterceptors() {
    //?. If the object is null, the expression will return null without throwing an error.
    //If dio is null, the expression does nothing (no logging interceptor is added), and no exception is thrown.
    dio?.interceptors.addAll([
      PrettyDioLogger(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ),
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final isConnected = await checkInternet();
          if (!isConnected) {
            return handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.connectionError,
                error: "No internet connection",
              ),
            );
          }

          // Continue with the request
          return handler.next(options);
        },
      ),
    ]);
  }
}
