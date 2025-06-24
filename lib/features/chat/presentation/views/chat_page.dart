import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saturn/core/helper/shared_pref_helper.dart';
import 'package:saturn/core/helper/shared_pref_keys.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/custom_listview_shimmer.dart';
import 'package:saturn/features/chat/presentation/widgets/list_of_users.dart';
import 'package:saturn/features/chat/presentation/widgets/chats_list_container.dart';
import 'package:saturn/features/home/logic/cubit/home_cubit.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    getUserId().then((userId) {
      context.read<HomeCubit>().getListOfUsersById(userId.toString());
    });
    super.initState();
  }

  Future<int> getUserId() async {
    return await SharedPrefHelper.getInt(SharedPrefKeys.userIdKey);
  }

  @override
  Widget build(BuildContext context) {
    // Access users directly from the cubit
    final users = context.watch<HomeCubit>().allUsers;
    final chatTileModels = context.watch<HomeCubit>().chatTileModels;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainPurple,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Builder(
            builder: (context) {
              // You can also add loading state or error fallback here
              final state = context.watch<HomeCubit>().state;

              if (state is GetAllUsersFailure) {
                return Center(
                  child: Text('there is an error ${state.errorMessage}'),
                );
              }

              if (users == null || users.isEmpty) {
                return const CustomListViewShimmer();
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(30),
                    Text(
                      'Messages',
                      style: AppTextstyles.font32BlueBold.copyWith(
                        color: AppColors.white,
                        fontSize: 26.sp,
                        fontFamily: GoogleFonts.pacifico().fontFamily,
                      ),
                    ),
                    verticalSpace(10),
                    Text(
                      'R e c e n t',
                      style: AppTextstyles.font13Greyregular.copyWith(
                        color: AppColors.lighterGrey,
                        fontSize: 16,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                    verticalSpace(30),
                    ListOfAllUsers(users: users),
                    ChatsListContainer(chatTileModels: chatTileModels),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
