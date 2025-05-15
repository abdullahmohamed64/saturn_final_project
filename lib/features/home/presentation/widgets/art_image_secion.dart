import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/app_functions.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/networking/api_constants.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/auth/models/user_model.dart';
import 'package:saturn/features/favourite/logic/cubit/favorite_cubit.dart';
import 'package:saturn/features/home/data/models/art_model.dart';

import 'package:saturn/features/home/logic/cubit/home_cubit.dart';

class ArtImageSecion extends StatelessWidget {
  const ArtImageSecion({
    super.key,
    this.onCommentPress,
    required this.artModel,
    required this.isLiked,
    required this.likesCount,
  });
  final void Function()? onCommentPress;
  final int likesCount;
  final ArtModel artModel;
  final bool isLiked;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            // context.read<ChatCubit>().getAllUsers();
            UserModel user =
                context.read<HomeCubit>().getUserById(artModel.userId!)!;
            context.pushNamed(Routes.chatRoomPage, args: user);
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.deepPurple,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(32.r),
              ),
            ),
            height: 280.h,
            width: double.infinity,
            child:
                artModel.imageName == null
                    ? Image.asset(Assets.assetsImagesBag, height: 280.h)
                    : Image.network(
                      ApiConstants.upload + artModel.imageName!,
                      fit: BoxFit.scaleDown,
                    ),
          ),
        ),
        Positioned(
          bottom: 10.h,
          right: 10.w,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(144, 127, 144, 159),

              borderRadius: BorderRadius.circular(16.sp),
            ),
            child: Row(
              children: [
                horizontalSpace(8),
                Text(
                  AppFunctions.formatDate(artModel.createdAt!),
                  style: AppTextstyles.font16WhiteSemiBold,
                ),
                horizontalSpace(100),
                Text(
                  likesCount.toString(),
                  style: AppTextstyles.font16WhiteMeduim,
                ),
                IconButton(
                  onPressed: () {
                    context.read<ArtCubit>().emitMakeReact(artId: artModel.id!);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: isLiked ? Colors.red : Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: onCommentPress,
                  icon: const Icon(Icons.comment, color: Colors.white),
                ),
                horizontalSpace(8),
              ],
            ),
          ),
        ),
        // Positioned(
        //   bottom: 20.h,
        //   left: 20.w,
        //   child: Text(artModel.createdAt!, style: AppTextstyles.font16WhiteSemiBold),
        // ),
      ],
    );
  }
}
