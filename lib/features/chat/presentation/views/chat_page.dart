import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saturn/core/di/dependency_injection.dart';
import 'package:saturn/core/helper/app_functions.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/helper/shared_pref_helper.dart';
import 'package:saturn/core/helper/shared_pref_keys.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/back_icon_button.dart';
import 'package:saturn/core/widgets/custom_listview_shimmer.dart';
import 'package:saturn/features/chat/presentation/widgets/list_of_users.dart';
import 'package:saturn/features/chat/presentation/widgets/chats_list_container.dart';
import 'package:saturn/features/home/logic/cubit/home_cubit.dart';
import 'package:saturn/features/home/presentation/widgets/custom_search_app_bar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    int uId = AppFunctions.getUserId() ?? 0;
    context.read<HomeCubit>().getListOfUsersById(uId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Access users directly from the cubit
    final users = context.watch<HomeCubit>().allUsers;
    final chatTileModels = context.watch<HomeCubit>().chatTileModels;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 132.h,
          backgroundColor: AppColors.white,

          leading: CustomBackIconButton(
            onPressed:
                () => context.pushNamedAndRemoveUntile(
                  Routes.navigationPage,
                  predicate: (route) => false,
                ),
          ),
        ),
        backgroundColor: AppColors.white,
        body: Builder(
          builder: (context) {
            // You can also add loading state or error fallback here
            final state = context.watch<HomeCubit>().state;

            if (state is GetAllUsersFailure) {
              return Center(
                child: Text('there is an error ${state.errorMessage}'),
              );
            }

            if (users == null || users.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      'Messages',
                      style: AppTextstyles.font32BlueBold.copyWith(
                        color: AppColors.black,
                        fontSize: 26.sp,
                        fontFamily: GoogleFonts.pacifico().fontFamily,
                      ),
                    ),
                  ),
                  verticalSpace(10),
                  // Text(
                  //   'R e c e n t',
                  //   style: AppTextstyles.font13Greyregular.copyWith(
                  //     color: AppColors.lighterGrey,
                  //     fontSize: 16,
                  //     fontFamily: GoogleFonts.poppins().fontFamily,
                  //   ),
                  // ),
                  verticalSpace(30),
                  ListOfAllUsers(users: users),
                  verticalSpace(20),
                  state is GetAllUsersLoading
                      ? Container(
                        height: 343.h,
                        padding: EdgeInsets.only(
                          top: 32.h,
                          right: 12.w,
                          left: 12.w,
                        ),

                        decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.r),
                            topRight: Radius.circular(50.r),
                          ),
                        ),

                        child: CustomListViewShimmer(height: 343),
                      )
                      : ChatsListContainer(chatTileModels: chatTileModels),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
