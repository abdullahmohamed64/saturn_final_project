import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:saturn/core/networking/api%20consumer/dio_consumer.dart';
import 'package:saturn/core/networking/api_service.dart';
import 'package:saturn/core/networking/dio_factory.dart';
import 'package:saturn/features/auth/sign%20in/data/repo/sign_in_repo.dart';
import 'package:saturn/features/auth/sign%20in/logic/cubit/sign_in_cubit.dart';
import 'package:saturn/features/auth/sign%20up/data/repo/sign_up_repo.dart';
import 'package:saturn/features/auth/sign%20up/logic/cubit/sign_up_cubit.dart';
import 'package:saturn/features/favourite/data/models/user_favourit_arts_model.dart';
import 'package:saturn/features/favourite/data/repo/favorite_repo.dart';

import 'package:saturn/features/favourite/logic/cubit/favorite_cubit.dart';
import 'package:saturn/features/favourite/logic/cubit/get_user_favorite_arts_cubit.dart';

import 'package:saturn/features/home/data/repo/home_repo.dart';
import 'package:saturn/features/home/logic/cubit/home_cubit.dart';

final getIt = GetIt.instance;
void setUpGetIt() {
  final Dio dio = DioFactory.getDio();
  final DioConsumer api = DioConsumer(dio: dio);
  //The ApiService is registered as a lazy singleton. This means it
  // will be created once (when it’s first needed) and then reused throughout the app
  getIt.registerLazySingleton<ApiService>(() => ApiService(api: api));

  //!!!!!!!!!!!!!!!!!!!!!!!! Sign up

  //The SignUpRepo (repository for sign-up actions) is registered as a factory. Every time you request a SignUpRepo,
  // a new instance is created. The repository depends on ApiService, so it is retrieved from GetIt
  getIt.registerLazySingleton<SignUpRepo>(
    () => SignUpRepo(apiService: getIt()),
  );

  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));

  //!!!!!!!!!!!!!!!!!!!!!!!! Signin
  getIt.registerLazySingleton<SignInRepo>(
    () => SignInRepo(apiService: getIt()),
  );
  getIt.registerFactory<SignInCubit>(() => SignInCubit(getIt()));

  //!!!!!!!!!!!! home

  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(apiService: getIt()));
  getIt.registerLazySingleton<HomeCubit>(() => HomeCubit(getIt()));

  //!!!!!!!!!!!favourite
  getIt.registerLazySingleton<FavouriteRepo>(
    () => FavouriteRepo(apiService: getIt()),
  );

  //!!!!!!!!!!! get user favourite arts

   getIt.registerLazySingleton<GetUserFavoriteArtsCubit>(() => GetUserFavoriteArtsCubit(getIt()));
}
