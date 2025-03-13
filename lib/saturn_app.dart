import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/di/dependency_injection.dart';
import 'package:saturn/core/routing/app_router.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/features/auth/sign%20up/logic/cubit/sign_up_cubit.dart';
import 'package:saturn/features/favourite/data/repo/favourite_repo.dart';
import 'package:saturn/features/favourite/logic/cubit/favourite_cubit.dart';
import 'package:saturn/features/home/data/repo/home_repo.dart';
import 'package:saturn/features/home/logic/cubit/home_cubit.dart';

class SaturnApp extends StatelessWidget {
  const SaturnApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<SignUpCubit>()),
          BlocProvider(create: (context) => HomeCubit(getIt<HomeRepo>())..getCategoyItems()),
         BlocProvider (create: (context) => FavoriteCubit(getIt<FavouriteRepo>()),)
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'saturn',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          onGenerateRoute: AppRouter.onGenerate,
          initialRoute: Routes.signInPage,
        ),
      ),
    );
  }
}
