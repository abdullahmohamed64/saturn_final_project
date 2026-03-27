
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItem extends StatelessWidget {
  const ShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey,
      highlightColor: AppColors.lighterGrey,
      child: 
      Container(
        decoration: BoxDecoration(
        color: AppColors.deepPurple,
borderRadius: BorderRadius.circular(16.sp)
        ),
        height: 100.h,),
      
    );
  }
}
