import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';

class DeepBlackContainer extends StatelessWidget {
  const DeepBlackContainer({super.key,});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),

        color: AppColors.black,
      ),
    );
  }
}
