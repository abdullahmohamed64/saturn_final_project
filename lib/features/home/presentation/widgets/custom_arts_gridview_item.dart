import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/app_functions.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/home/data/models/art_model.dart';

class CustomHomeArtsGridViewItem extends StatelessWidget {
  const CustomHomeArtsGridViewItem({super.key, required this.artModel});
  final ArtModel artModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            bottom: 24.h,
            right: 16.w,
            left: 16.w,
            top: 5.h,
          ),
          height: 130.h,
          width: 100.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.sp),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.lightPurple,
                const Color.fromARGB(255, 65, 36, 122),
                const Color.fromARGB(255, 59, 15, 109),
              ],
            ),
            color: AppColors.lightGrey,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.sp),
            child: Image.asset(Assets.assetsImagesArts, height: 50, width: 50),

            // CachedNetworkImage(
            //   imageUrl: ApiConstants.upload + artModel.imageName,
            //   placeholder: (context, url) =>
            //       const CircularProgressIndicator(),
            //   imageBuilder: (context, imageProvider) {
            //     return Container(
            //       decoration: BoxDecoration(
            //           image: DecorationImage(
            //         image: imageProvider,
            //         fit: BoxFit.fill,
            //       ),),
            //     );
            //   },
            // ),
          ),
        ),
        verticalSpace(4),

        Text(
          artModel.categoryName ?? 'no title',
          style: AppTextstyles.font16WhiteMeduim.copyWith(fontSize: 14.sp),
        ),
        verticalSpace(4),

        // Text(
        //   textAlign: TextAlign.center,
        //   maxLines: 2,
        //   overflow: TextOverflow.ellipsis,
        //  AppFunctions.formatDate( artModel.createdAt ?? ''),
        //   style: AppTextstyles.font16WhiteMeduim.copyWith(fontSize: 14.sp),
        // ),
        Text(
          artModel.type ?? 'no type',
          style: AppTextstyles.font16WhiteMeduim.copyWith(fontSize: 14.sp),
        ),
      ],
    );
  }
}
