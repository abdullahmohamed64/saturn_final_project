import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:saturn/core/di/dependency_injection.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/features/add%20post/presentation/views/add_post_page.dart';
import 'package:saturn/features/auth/models/user_model.dart';
import 'package:saturn/features/auth/sign%20in/logic/cubit/sign_in_cubit.dart';
import 'package:saturn/features/auth/sign%20in/presentation/views/reset_password_page.dart';
import 'package:saturn/features/auth/sign%20in/presentation/views/set_new_password_page.dart';
import 'package:saturn/features/auth/sign%20up/presentation/views/complete_profile_page.dart';
import 'package:saturn/features/auth/sign%20up/presentation/views/sign_up_page.dart';
import 'package:saturn/features/auth/views/login_succefully_page.dart';
import 'package:saturn/features/chat/data/models/chat_title_model.dart';
import 'package:saturn/features/chat/presentation/views/chat_page.dart';
import 'package:saturn/features/chat/presentation/views/chat_room_page.dart';
import 'package:saturn/features/favourite/logic/cubit/get_user_favorite_arts_cubit.dart';
import 'package:saturn/features/favourite/presentation/views/favourite_page.dart';
import 'package:saturn/features/home/data/models/art_model.dart';
import 'package:saturn/features/home/data/models/categorys_response_model.dart';
import 'package:saturn/features/home/data/repo/home_repo.dart';
import 'package:saturn/features/home/logic/cubit/home_cubit.dart';
import 'package:saturn/features/home/presentation/views/art_page.dart';
import 'package:saturn/features/home/presentation/views/category_page.dart';
import 'package:saturn/features/home/presentation/views/home_page.dart';
import 'package:saturn/features/home/presentation/views/navigation_page.dart';
import 'package:saturn/features/on%20boarding/on_boarding_page.dart';
import 'package:saturn/features/auth/sign%20in/presentation/views/sign_in_page.dart';
import 'package:saturn/features/profile/data/repo/edit_user_repo.dart';
import 'package:saturn/features/profile/logic/edit%20user%20cubit/edit_user_profile_cubit.dart';
import 'package:saturn/features/profile/presentaion/views/edit_user_profile_view.dart';
import 'package:saturn/features/profile/presentaion/views/profile_page.dart';

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

      case Routes.navigationPage:
        return MaterialPageRoute(
          builder: (_) {
            return NavigationPage();
          },
        );
      case Routes.categoryPage:
        return MaterialPageRoute(
          builder: (_) {
            return CategoryPage(
              categoryName: routeSettings.arguments as String,
            );
          },
        );
      case Routes.chatPage:
        return MaterialPageRoute(
          builder: (_) {
            return ChatPage();
          },
        );
      case Routes.profilePage:
        return MaterialPageRoute(
          builder: (_) {
            return ProfilePage();
          },
        );
      case Routes.addPostPage:
        return MaterialPageRoute(
          builder: (_) {
            return AddPostPage();
          },
        );
      case Routes.homePage:
        return MaterialPageRoute(
          builder: (_) {
            return HomePage();
          },
        );
      case Routes.artViewPage:
        return MaterialPageRoute(
          builder: (_) {
            return ArtPage(artModel: routeSettings.arguments as ArtModel);
          },
        );

      case Routes.favouritePage:
        return MaterialPageRoute(
          builder: (_) {
            return FavouritePage();
          },
        );
      case Routes.editProfilePage:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider(
              create: (context) => EditUserProfileCubit(getIt<EditUserRepo>()),
              child: EditUserProfileView(
                userModel: routeSettings.arguments as UserModel,
              ),
            );
          },
        );
      case Routes.chatRoomPage:
        return MaterialPageRoute(
          builder: (_) {
            return ChatRoomPage(
              chatTileModel: routeSettings.arguments as ChatTileModel,
            );
          },
        );

      default:
        return null;
    }
  }
}
