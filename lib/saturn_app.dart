import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/di/dependency_injection.dart';
import 'package:saturn/core/routing/app_router.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/features/auth/sign%20up/logic/cubit/sign_up_cubit.dart';

class SaturnApp extends StatelessWidget {
  const SaturnApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      child: BlocProvider(
        create: (context) => getIt<SignUpCubit>(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'saturn',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          onGenerateRoute: AppRouter.onGenerate,
          initialRoute: Routes.homePage,
        ),
      ),
    );
  }
}
