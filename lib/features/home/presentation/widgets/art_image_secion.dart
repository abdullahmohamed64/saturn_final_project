import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/favourite/logic/cubit/favorite_cubit.dart';

import 'package:saturn/features/home/data/models/categorys_response_model.dart';

class ArtImageSecion extends StatelessWidget {
  const ArtImageSecion({
    super.key,
    this.onCommentPress,
    required this.artId,
    required this.isLiked,
    required this.likesCount,
  });
  final void Function()? onCommentPress;
  final int likesCount;
  final int artId;
  final bool isLiked;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.deepPurple,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(32.r),
            ),
          ),
          height: 280.h,
          width: double.infinity,
          child: Image.asset(Assets.assetsImagesBag, height: 280.h),
        ),
        Positioned(
          bottom: 10.h,
          right: 10.w,
          child: Row(
            children: [
              Text(
                likesCount.toString(),
                style: AppTextstyles.font16WhiteMeduim,
              ),
              IconButton(
                onPressed: () {
                  context.read<ArtCubit>().emitMakeReact(artId: artId);
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
            ],
          ),
        ),
        Positioned(
          bottom: 20.h,
          left: 20.w,
          child: Text('2025/4/1', style: AppTextstyles.font16WhiteSemiBold),
        ),
      ],
    );
  }
}
