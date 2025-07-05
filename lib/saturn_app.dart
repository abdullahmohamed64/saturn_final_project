
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/di/dependency_injection.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/helper/shared_pref_helper.dart';
import 'package:saturn/core/helper/shared_pref_keys.dart';
import 'package:saturn/core/routing/app_router.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/features/auth/sign%20up/logic/cubit/sign_up_cubit.dart';
import 'package:saturn/features/favourite/data/repo/favorite_repo.dart';
import 'package:saturn/features/favourite/logic/cubit/favorite_cubit.dart';
import 'package:saturn/features/home/data/repo/home_repo.dart';
import 'package:saturn/features/home/logic/cubit/home_cubit.dart';
import 'package:saturn/features/profile/data/repo/user_profile_repo.dart';
import 'package:saturn/features/profile/logic/user%20profile%20cubit/user_profile_cubit_.dart';

final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

class SaturnApp extends StatefulWidget {
  const SaturnApp({super.key});

  @override
  State<SaturnApp> createState() => _SaturnAppState();
}

class _SaturnAppState extends State<SaturnApp> {
  @override
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<SignUpCubit>()),
          BlocProvider(
            create:
                (context) =>
                    HomeCubit(getIt<HomeRepo>())
                      ..getCategoyItems()
                      ..getAllUsers(),
          ),
          BlocProvider(create: (context) => ArtCubit(getIt<FavouriteRepo>())),

          BlocProvider(
            create: (context) => UserProfileCubit(getIt<UserProfileRepo>()),
          ),
        ],
        child: MaterialApp(
          navigatorKey: navigator,
          debugShowCheckedModeBanner: false,
          title: 'saturn',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.appBarColorPurple,
            ),
          ),
          onGenerateRoute: AppRouter.onGenerate,
          initialRoute: getInitialRouteMethod(),
        ),
      ),
    );
  }
}

//ali54@gmail.com
//wa12@gmail.com
//mousa12@gmail.com

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

String getInitialRouteMethod() {
  if (getIt<SharedPrefHelper>().getBool(SharedPrefKeys.visitedOnBoarding)) {

    if (!getIt<SharedPrefHelper>()
        .getInt(SharedPrefKeys.userIdKey).toString()
        .isNullOrEmpty()) {
      return Routes.navigationPage;
    } else {
      return Routes.signInPage;
    }
  } else {
    return Routes.onBoardingPage;
  }
}
