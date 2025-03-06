import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:saturn/core/networking/api_constants.dart';
import 'package:saturn/features/auth/sign%20up/data/models/sign_up_request_model.dart';
import 'package:saturn/features/auth/sign%20up/data/models/sign_up_response_model.dart';
part 'api_service.g.dart';

//The @RestApi annotation tells Retrofit that this interface is a REST API client. The base URL is provided by ApiConstants.baseUrl
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.signUp)
  Future<SignUpResponseModel> signUp(
    @Body() SignUpRequestModel signUpRequestModel,
  );
}
