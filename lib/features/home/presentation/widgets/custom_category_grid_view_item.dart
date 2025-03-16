import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/home/data/models/art_model.dart';

class CustomCategoryGridviewItem extends StatelessWidget {
  const CustomCategoryGridviewItem({super.key, required this.artModel});
  final ArtModel artModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 200.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.lightPurple,
            const Color.fromARGB(255, 78, 45, 143),
            const Color.fromARGB(255, 59, 15, 109),
          ],
        ),
        color: AppColors.lightPurple,
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(Assets.assetsImagesBag, height: 100.h, width: 70.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                  artModel.categoryName ?? '',
                  style: AppTextstyles.font16WhitekSemiBold,
                ),
              ),
              verticalSpace(30),
              Flexible(
                child: Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                  artModel.description ?? '',
                  style: AppTextstyles.font16WhitekSemiBold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
