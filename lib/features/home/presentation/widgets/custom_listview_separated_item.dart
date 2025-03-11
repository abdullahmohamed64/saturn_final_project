import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_textstyles.dart';

class CustomCategoryListviewSparatedItem extends StatelessWidget {
  const CustomCategoryListviewSparatedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.sp)),
          child: Image.asset(
            Assets.assetsImagesBag,
            height: 100.h,
            width: 120.w,
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
