
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';

class CustomCategoryGridviewItem extends StatelessWidget {
  const CustomCategoryGridviewItem({
    super.key,
  });

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
          Image.asset(
            Assets.assetsImagesBag,
            height: 100.h,
            width: 70.w,
          ),
          Wrap(
            children: [
              Text(
                'Design \nHandMade ',
                style: AppTextstyles.font16WhitekSemiBold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
