import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:saturn/core/networking/api_service.dart';
import 'package:saturn/core/networking/dio_factory.dart';
import 'package:saturn/features/auth/sign%20up/data/repo/sign_up_repo.dart';
import 'package:saturn/features/auth/sign%20up/logic/cubit/sign_up_cubit.dart';

final getIt = GetIt.instance;
void setUpGetIt() {
  final Dio dio = DioFactory.getDio();

  //The ApiService is registered as a lazy singleton. This means it
  // will be created once (when it’s first needed) and then reused throughout the app
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));



  //The SignUpRepo (repository for sign-up actions) is registered as a factory. Every time you request a SignUpRepo,
  // a new instance is created. The repository depends on ApiService, so it is retrieved from GetIt
  getIt.registerLazySingleton<SignUpRepo>(
    () => SignUpRepo(apiService: getIt()),
  );

  
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt())); ///

}
