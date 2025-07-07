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
  final PostModel artModel;
  final bool isLiked;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // context.read<ChatCubit>().getAllUsers();
            UserModel user =
                context.read<HomeCubit>().getUserById(artModel.userId!)!;
            context.pushNamed(Routes.chatRoomPage, args: user);
          },
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.sp),
            ),
            height: 183.h,
            width: 244.w,
            child:
                artModel.imageName == null
                    ? Image.asset(Assets.assetsImagesBag, height: 280.h)
                    : Image.network(
                      ApiConstants.uploadUrl.toString() + artModel.imageName!,
                      fit: BoxFit.contain,
                    ),
          ),
        ),
        verticalSpace(25),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24.w),
          decoration: BoxDecoration(
            color: const Color(0xFF2F2F2F),

            borderRadius: BorderRadius.circular(16.sp),
          ),
          child: Row(
            children: [
              horizontalSpace(12),
              Text(
                AppFunctions.formatDate2(artModel.createdAt!),
                style: AppTextstyles.font16WhiteSemiBold,
              ),
              Spacer(),
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
                icon: const Icon(Icons.comment_outlined, color: Colors.white),
              ),
              horizontalSpace(12),
            ],
          ),
        ),
   
      ],
    );
  }
}
