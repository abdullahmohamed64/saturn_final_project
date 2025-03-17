import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:saturn/core/di/dependency_injection.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/features/add%20post/logic/cubit/add_post_cubit.dart';
import 'package:saturn/features/add%20post/presentation/views/add_post_page.dart';
import 'package:saturn/features/chat/presentation/views/chat_page.dart';
import 'package:saturn/features/favourite/logic/cubit/get_user_favorite_arts_cubit.dart';
import 'package:saturn/features/favourite/presentation/views/favourite_page.dart';
import 'package:saturn/features/home/presentation/views/home_page.dart';
import 'package:saturn/features/profile/presentaion/views/profile_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentPage = 0;
  List<Widget> pages = [
    HomePage(),
    ChatPage(),
    AddPostPage(),
    ProfilePage(),
    FavouritePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepPurple,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav(
          onTabChange: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          gap: 8.w,
          color: AppColors.white,
          tabBackgroundColor: AppColors.lightPurple,
          padding: EdgeInsets.all(16),
          activeColor: Colors.white,
          tabs: [
            GButton(icon: LineIcons.home, text: 'Home'),
            GButton(icon: Icons.message, text: 'Chat'),
            GButton(icon: Icons.add, text: 'Add post'),
            GButton(icon: Icons.person, text: 'Profile'),
            GButton(icon: LineIcons.heartAlt, text: 'Favourites'),
          ],
        ),
      ),
      body: _selectBody(_currentPage)
    );
  }

  Widget _selectBody(int i) {
    if (i == 2) {
      return BlocProvider(
        create: (context) => AddPostCubit(getIt()),
        child: pages.elementAt(i),
      );
    } else if (i == 4) {
      return BlocProvider(
        create:
            (context) =>
                GetUserFavoriteArtsCubit(getIt())..emitGetUserFavoriteArts(),
        child: pages.elementAt(i),
      );
    } else {
      return pages.elementAt(i);
    }
  }
}
