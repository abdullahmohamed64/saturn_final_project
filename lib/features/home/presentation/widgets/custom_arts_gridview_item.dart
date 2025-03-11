import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';

class CustomArtsGridViewItem extends StatelessWidget {
  const CustomArtsGridViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120.h,
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
          child: Column(
            children: [
              verticalSpace(10),
              Image.asset(Assets.assetsImagesBag, height: 80.h, width: 100.w),
            ],
          ),
        ),
        verticalSpace(10),
        Text(
          'painting',
          style: AppTextstyles.font16WhiteMeduim.copyWith(fontSize: 14.sp),
        ),
      ],
    );
  }
}
