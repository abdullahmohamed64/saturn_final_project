import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturn/core/di/dependency_injection.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/features/auth/sign%20in/logic/cubit/sign_in_cubit.dart';
import 'package:saturn/features/auth/sign%20in/presentation/views/reset_password_page.dart';
import 'package:saturn/features/auth/sign%20in/presentation/views/set_new_password_page.dart';
import 'package:saturn/features/auth/sign%20up/presentation/views/complete_profile_page.dart';
import 'package:saturn/features/auth/sign%20up/presentation/views/sign_up_page.dart';
import 'package:saturn/features/auth/views/login_succefully_page.dart';
import 'package:saturn/features/home/presentation/views/home_page.dart';
import 'package:saturn/features/on%20boarding/on_boarding_page.dart';
import 'package:saturn/features/auth/sign%20in/presentation/views/sign_in_page.dart';

import '../../features/auth/sign up/presentation/views/confirm_email_page.dart';

class AppRouter {
  static Route? onGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.onBoardingPage:
        return MaterialPageRoute(
          builder: (_) {
            return OnBoardingPage();
          },
        );
      case Routes.signInPage:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider(
              create: (context) => getIt<SignInCubit>(),
              child: SignInPage(),
            );
          },
        );
      case Routes.signUpPage:
        return MaterialPageRoute(
          builder: (_) {
            return SignUpPage();
          },
        );
      case Routes.confirmEmailPage:
        return MaterialPageRoute(
          builder: (_) {
            return ConfirmEmail();
          },
        );
      case Routes.resetPasswordPage:
        return MaterialPageRoute(
          builder: (_) {
            return ResetPasswordPage();
          },
        );

      case Routes.completeProfile:
        return MaterialPageRoute(
          builder: (_) {
            return CompleteProfilePage();
          },
        );
      case Routes.setNewPassword:
        return MaterialPageRoute(
          builder: (_) {
            return SetNewPasswordPage();
          },
        );

      case Routes.loginSuccefullyPage:
        return MaterialPageRoute(
          builder: (_) {
            return LoginSuccefullyPage();
          },
        );

      case Routes.homePage:
        return MaterialPageRoute(
          builder: (_) {
            return HomePage();
          },
        );
      default:
        return null;
    }
  }
}
